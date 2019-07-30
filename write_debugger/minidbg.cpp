#include <iostream>
#include <sstream>
#include <vector>
#include <optional>

#include <unistd.h>
#include <sys/ptrace.h>
#include <sys/types.h>

class breakpoint {
public:
    breakpoint(pid_t pid, std::intptr_t addr)
        : pid_{pid}, addr_{addr}, enabled_{false}, saved_data_{}
    {}

    void enable();
    void disable();

    auto is_enabled() const -> bool { return enabled_; }
    auto get_address() const -> std::intptr_t { return addr_; }

private:
    pid_t pid_;
    std::intptr_t addr_;
    bool enabled_;
    uint8_t saved_data_;
};

void breakpoint::enable() {
    auto data = ptrace(PTRACE_PEEKDATA, pid_, addr_, nullptr);
    saved_data_ = static_cast<uint8_t>(data & 0xff);

    uint64_t int3 = 0xcc;
    uint64_t data_with_int3 = ((data & ~0xff) | int3);
    ptrace(PTRACE_POKEDATA, pid_, addr_, data_with_int3);

    enabled_ = true;
}

void breakpoint::disable() {
    auto data = ptrace(PTRACE_PEEKDATA, pid_, addr_, nullptr);
    auto restored_data = ((data & ~0xff) | saved_data_);
    ptrace(PTRACE_POKEDATA, pid_, addr_, restored_data);

    enabled_ = false;
}

class debugger {
public:
    debugger(std::string prog_name, pid_t pid)
        : prog_name_{prog_name}, pid_{pid} 
    {}

    void run();
    void handle_command(std::string const&);
    void continue_execution();

    void set_breakpoint_at_address(std::intptr_t addr);

private:
    std::unordered_map<std::intptr_t, breakpoint> breakpoints_;
    std::string prog_name_;
    pid_t pid_;
};

std::optional<std::string> getInput(std::string const& str) {
    std::cout << str;
    std::string input;
    std::getline(std::cin, input);
    if (input == "quit" or input == "q")
        return std::nullopt;

    return std::optional{input};
}

void debugger::set_breakpoint_at_address(std::intptr_t addr) {
    std::cout << "set braekpoint at address 0x" << std::hex << addr << std::endl;
    breakpoint bp{pid_, addr};
    bp.enable();
    breakpoints_[addr] = bp;
}

void debugger::run() {
    int wait_status;
    int options = 0;
    waitpid(pid_, &wait_status, options);

    std::optional<std::string> line;
    while ((line = getInput("minidbg> "))) {  
        handle_command(*line);
    }
}

std::vector<std::string> split(std::string const& s, char delimiter) {
    std::vector<std::string> out{};
    std::stringstream ss{s};
    std::string item;

    while (std::getline(ss, item, delimiter)) {
        out.push_back(item);
    }

    return out;
}

bool is_prefix(std::string const& s, std::string const& of) {
    if (s.size() > of.size()) return false;
    return std::equal(s.begin(), s.end(), of.begin());
}

void debugger::handle_command(std::string const& line) {
    auto args = split(line, ' ');
    auto command = args[0];

    if (is_prefix(command, "continue")) {
        continue_execution();
    } else if (is_prefix(command, "break")) {
        std::string addr{args[1], 2};
        set_breakpoint_at_addrss(std::stol(addr, 0, 16));
    }
    } else {
        std::cerr << "unknown command" << std::endl;
    }
}

void debugger::continue_execution() {
    // on linux PTRACE_CONT
    ptrace(PT_CONTINUE, pid_, nullptr, 0);

    int wait_status;
    int options = 0;
    waitpid(pid_, &wait_status, options);
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        std::cerr << "program name not specified" << std::endl;
        return -1;
    }

    auto prog = argv[1];

    auto pid = fork();
    if (pid == 0) {
        // in child process
        // execute debugee
        std::cout << "child..." << std::endl;
        // on linux PTRACE_TRACEME
        ptrace(PT_TRACE_ME, 0, nullptr, 0);
        execl(prog, prog, nullptr);
    } else if (pid >= 1) {
        // we are in parent
        // execute debugger
        std::cout << "parent... child's pid = " << pid << std::endl;
        debugger dbg{prog, pid};
        dbg.run();
    }
}
