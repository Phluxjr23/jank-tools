CC = gcc
CXX = g++
RUSTC = rustc
GOC = go build
NASM = nasm
LD = ld
CFLAGS = -Wall -O2
CXXFLAGS = -Wall -O2 -std=c++17
NASMFLAGS = -f elf64
INSTALL_DIR = /usr/local/bin

# c sources
C_SOURCES = $(wildcard scripts/*.c)
C_TARGETS = $(patsubst scripts/%.c,compiled/%,$(C_SOURCES))

# c++ sources
CPP_SOURCES = $(wildcard scripts/*.cpp)
CPP_TARGETS = $(patsubst scripts/%.cpp,compiled/%,$(CPP_SOURCES))

# rust sources
RUST_SOURCES = $(wildcard scripts/*.rs)
RUST_TARGETS = $(patsubst scripts/%.rs,compiled/%,$(RUST_SOURCES))

# go sources
GO_SOURCES = $(wildcard scripts/*.go)
GO_TARGETS = $(patsubst scripts/%.go,compiled/%,$(GO_SOURCES))

# asm sources
ASM_SOURCES = $(wildcard scripts/*.asm)
ASM_TARGETS = $(patsubst scripts/%.asm,compiled/%,$(ASM_SOURCES))

ALL_TARGETS = $(C_TARGETS) $(CPP_TARGETS) $(RUST_TARGETS) $(GO_TARGETS) $(ASM_TARGETS)

all: $(ALL_TARGETS)

# compile c files
compiled/%: scripts/%.c
	@mkdir -p compiled
	$(CC) $(CFLAGS) -o $@ $<
	@echo "compiled $@"

# compile c++ files
compiled/%: scripts/%.cpp
	@mkdir -p compiled
	$(CXX) $(CXXFLAGS) -o $@ $<
	@echo "compiled $@"

# compile rust files
compiled/%: scripts/%.rs
	@mkdir -p compiled
	$(RUSTC) -O -o $@ $<
	@echo "compiled $@"

# compile go files
compiled/%: scripts/%.go
	@mkdir -p compiled
	cd scripts && $(GOC) -o ../compiled/$(notdir $@) $(notdir $<)
	@echo "compiled $@"

# compile asm files
compiled/%: scripts/%.asm
	@mkdir -p compiled
	$(NASM) $(NASMFLAGS) scripts/$*.asm -o scripts/$*.o
	$(LD) scripts/$*.o -o $@
	@rm -f scripts/$*.o
	@echo "compiled $@"

install: all
	@echo "installing to $(INSTALL_DIR)..."
	@for bin in $(ALL_TARGETS); do \
		install -m 755 $$bin $(INSTALL_DIR)/$$(basename $$bin); \
	done
	@echo "installed successfully"

uninstall:
	@echo "removing from $(INSTALL_DIR)..."
	@for bin in $(ALL_TARGETS); do \
		rm -f $(INSTALL_DIR)/$$(basename $$bin); \
	done
	@echo "uninstalled successfully"

clean:
	@rm -rf compiled
	@rm -f scripts/*.o
	@echo "cleaned compiled binaries"

.PHONY: all install uninstall clean
