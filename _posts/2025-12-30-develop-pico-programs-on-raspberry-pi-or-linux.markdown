---
layout: post
title: Develop Pico programs on Raspberry Pi or Linux
date: 2025-12-30
categories: [computer]
tags: [Raspberry-Pi,CMake,GDB]
mathjax: false
---

- [Development environment setup](#org856d370)
- [Use CMake to manage and build projects](#org46ed944)
- [Use picotool to download binaries to Pico](#org1cafdc3)
- [Use minicom to acquire printf messages from Pico](#org6c84aad)
- [Debug Pico programs](#orgff66dc8)
  - [Hardware and software preparation for debugging Pico programs](#org7a34115)
  - [Procedures for debugging Pico programs](#orgbca18b0)
  - [Usage of GDB](#org26d6aa2)

<a id="org856d370"></a>

# Development environment setup


<a id="org46ed944"></a>

# Use CMake to manage and build projects

Example `CMakeLists.txt` for the `hello-world` target:

```cmake
set(_target hello-world)
add_executable(${_target} hello-world.S)

# Enable UART output and disable USB output. With UART, we can debug Pico
# program and receive print messages via minicom.
pico_enable_stdio_usb(${_target} 0)
pico_enable_stdio_uart(${_target} 1)
# General additional output files from ELF firmware target, including UF2, bin,
# dis, hex and map files.
pico_add_extra_outputs(${_target})

target_link_libraries(${_target} pico_stdlib)
```

Configure and build the project:

```bash
mkdir pico-dev-build
cd pico-dev-build
cmake -DCMAKE_BUILD_TYPE=Debug -DPICO_BOARD=pico2_w ../pico-dev
make -j4 all
```


<a id="org1cafdc3"></a>

# Use picotool to download binaries to Pico

-   It should be run with `sudo`.
-   Load a program into the flash when Pico is in the `BOOTSEL` mode: `sudo picotool load <filename.uf2>`
    
    If Pico is in the application mode, execute `sudo picotool load -f <filename.uf2>`, which will force Pico to reboot into `BOOTSEL` mode, then load the program to flash.
-   Enable Pico program to support communication via USB, so that we can use `picotool` to control the running mode of Pico.
    -   CMake configuration
        
        ```cmake
        # enable usb output, disable uart output
        pico_enable_stdio_usb(${_target} 1)
        pico_enable_stdio_uart(${_target} 0)
        ```
        
        The standard USB connection is used for initial programming via the BOOTSEL mode or for basic serial communication (e.g., printf output), but not for interactive, step-through debugging. For program debugging, we need to use the UART mode.
        
        ```cmake
        pico_enable_stdio_usb(${_target} 0)
        pico_enable_stdio_uart(${_target} 1)
        ```
    
    -   In the source code, include the header file `stdio.h` and call `stdio_init_all()` at the beginning of `main`.
-   Reboot the device into application mode: `sudo picotool reboot` or `sudo picotool reboot -a`
-   Reboot the device into BOOTSEL mode: `sudo picotool reboot -u`


<a id="org6c84aad"></a>

# Use minicom to acquire printf messages from Pico

Receive messages from Pico via UART or USB:

```bash
sudo minicom -b 115200 -D /dev/ttyACM0
```


<a id="orgff66dc8"></a>

# Debug Pico programs


<a id="org7a34115"></a>

## Hardware and software preparation for debugging Pico programs


<a id="orgbca18b0"></a>

## Procedures for debugging Pico programs

-   Enable UART for the program to be debugged by editing `CMakeLists.txt`, where `${_target}` is the target name.
    
    ```cmake
    pico_enable_stdio_usb(${_target} 0)
    pico_enable_stdio_uart(${_target} 1)
    ```
-   Configure and build the project in the debug mode, so that debugging symbols will be written into the binary file.
    
    ```bash
    cd pico-dev-build
    cmake -DCMAKE_BUILD_TYPE=Debug -DPICO_BOARD=pico2_w ../pico-dev
    make -j4 all
    ```
-   Download the ELF file to Pico via `openocd`.
    
    ```bash
    sudo openocd -f interface/cmsis-dap.cfg -f target/rp2350.cfg -c "adapter speed 5000" -c "program <target>.elf verify reset exit"
    ```
    
    After execute, the following message appears:
    
    ```text
    Open On-Chip Debugger 0.12.0+dev (2025-10-24-02:10)
    Licensed under GNU GPL v2
    For bug reports, read
            http://openocd.org/doc/doxygen/bugs.html
    Info : [rp2350.cm0] Hardware thread awareness created
    Info : [rp2350.cm1] Hardware thread awareness created
    ocd_process_reset_inner
    adapter speed: 5000 kHz
    Info : Using CMSIS-DAPv2 interface with VID:PID=0x2e8a:0x000c, serial=E6647C74030E872F
    Info : CMSIS-DAP: SWD supported
    Info : CMSIS-DAP: Atomic commands supported
    Info : CMSIS-DAP: Test domain timer supported
    Info : CMSIS-DAP: FW Version = 2.0.0
    Info : CMSIS-DAP: Interface Initialised (SWD)
    Info : SWCLK/TCK = 0 SWDIO/TMS = 0 TDI = 0 TDO = 0 nTRST = 0 nRESET = 0
    Info : CMSIS-DAP: Interface ready
    Info : clock speed 5000 kHz
    Info : SWD DPIDR 0x4c013477
    Info : [rp2350.cm0] Cortex-M33 r1p0 processor detected
    Info : [rp2350.cm0] target has 8 breakpoints, 4 watchpoints
    Info : [rp2350.cm0] Examination succeed
    Info : [rp2350.cm1] Cortex-M33 r1p0 processor detected
    Info : [rp2350.cm1] target has 8 breakpoints, 4 watchpoints
    Info : [rp2350.cm1] Examination succeed
    Info : [rp2350.cm0] starting gdb server on 3333
    Info : Listening on port 3333 for gdb connections
    [rp2350.cm0] halted due to debug-request, current mode: Thread
    xPSR: 0xf9000000 pc: 0x00000088 msp: 0xf0000000
    [rp2350.cm1] halted due to debug-request, current mode: Thread
    xPSR: 0xf9000000 pc: 0x00000088 msp: 0xf0000000
    Info : RP2350 rev 2, QSPI Flash win w25q32fv/jv id = 0x1640ef size = 4096 KiB in 1024 sectors
    Info : RP2xxx ROM API function FC @ 3711
    ** Programming Started **
    Info : Padding image section 2 at 0x10003e24 with 220 bytes (bank write end alignment)
    Warn : Adding extra erase range, 0x10003f00 .. 0x10003fff
    ** Programming Finished **
    ** Verify Started **
    ** Verified OK **
    ** Resetting Target **
    shutdown command invoked
    ```
    
    The above two files on the command line, `interface/cmsis-dap.cfg` and `target/rp2350.cfg`, can be found in `/usr/local/share/openocd/scripts` after installing `openocd`.
    
    A script `send-elf.sh` has been created in the `pico-dev/scripts` folder to assist typing the above command line. Run it as `send-elf.sh <elf-file>`.

-   Start `openocd` in server mode, which listens to the port `3333` on localhost.
    
    ```bash
    sudo openocd -f interface/cmsis-dap.cfg -f target/rp2350.cfg -c "adapter speed 5000"
    ```
    
    The following message appears:
    
    ```text
    Open On-Chip Debugger 0.12.0+dev (2025-10-24-02:10)
    Licensed under GNU GPL v2
    For bug reports, read
            http://openocd.org/doc/doxygen/bugs.html
    Info : [rp2350.cm0] Hardware thread awareness created
    Info : [rp2350.cm1] Hardware thread awareness created
    ocd_process_reset_inner
    adapter speed: 5000 kHz
    Info : Listening on port 6666 for tcl connections
    Info : Listening on port 4444 for telnet connections
    Info : Using CMSIS-DAPv2 interface with VID:PID=0x2e8a:0x000c, serial=E6647C74030E872F
    Info : CMSIS-DAP: SWD supported
    Info : CMSIS-DAP: Atomic commands supported
    Info : CMSIS-DAP: Test domain timer supported
    Info : CMSIS-DAP: FW Version = 2.0.0
    Info : CMSIS-DAP: Interface Initialised (SWD)
    Info : SWCLK/TCK = 0 SWDIO/TMS = 0 TDI = 0 TDO = 0 nTRST = 0 nRESET = 0
    Info : CMSIS-DAP: Interface ready
    Info : clock speed 5000 kHz
    Info : SWD DPIDR 0x4c013477
    Info : [rp2350.cm0] Cortex-M33 r1p0 processor detected
    Info : [rp2350.cm0] target has 8 breakpoints, 4 watchpoints
    Info : [rp2350.cm0] Examination succeed
    Info : [rp2350.cm1] Cortex-M33 r1p0 processor detected
    Info : [rp2350.cm1] target has 8 breakpoints, 4 watchpoints
    Info : [rp2350.cm1] Examination succeed
    Info : [rp2350.cm0] starting gdb server on 3333
    Info : Listening on port 3333 for gdb connections
    ```
    
    The `openocd` process will occupy the terminal until it is closed by pressing `Ctrl+c`.
    
    A script `start-openocd.sh` has been created in the `pico-dev/scripts` folder to assist typing the above command line. Run it as `start-openocd.sh`.

-   After the `openocd` server starts, open another terminal and run `gdb-multiarch` (on Linux) or `gdb` on Raspberry Pi OS in another terminal.
    
    ```bash
    gdb-multiarch/gdb <target>.elf
    ```
    
    We can see this message:
    
    ```text
    Reading symbols from hello-world.elf...
    ```
    
    In the interactive session of GDB:
    
    -   Connect to the `openocd` server.
        
        ```text
        target remote localhost:3333
        ```
        
        We should see the following message indicating GDB has connected to `localhost:3333` and the program stops at `uart_tx_wait_blocking`.
        
        ```text
        Remote debugging using localhost:3333
        warning: multi-threaded target stopped without sending a thread-id, using first non-exited thread
        uart_tx_wait_blocking (uart=0x40070000)
            at pico-sdk/src/rp2_common/hardware_uart/include/hardware/uart.h:432
        432         while (uart_get_hw(uart)->fr & UART_UARTFR_BUSY_BITS) tight_loop_contents();
        ```
    -   Send `reset init` to the remote monitor `openocd` via the `monitor` command in GDB.
        
        ```text
        monitor reset init
        ```
        
        This will reset Pico and run `openocd`&rsquo;s initialization sequence, then the program halts before the `main` function.
        
        We should see this message:
        
        ```text
        [rp2350.cm0] halted due to debug-request, current mode: Thread
        xPSR: 0xf9000000 pc: 0x00000088 msp: 0xf0000000
        [rp2350.cm1] halted due to debug-request, current mode: Thread
        xPSR: 0xf9000000 pc: 0x00000088 msp: 0xf0000000
        RP2xxx ROM API function FC @ 3711
        available
        ```
        
        The GDB commands in the previous two steps are written to the file `pico-dev/scripts/gdbinit`. We can let GDB execute these commands directly when GDB starts by running `gdb -x pico-dev/scripts/gdbinit <elf-file>` on the command line.
    -   Then we can set breakpoints and run the program. For example, set a breakpoint at the entrance of the `main` function:
        
        ```text
        b main
        ```
        
        We should see this message:
        
        ```text
        Breakpoint 1 at 0x10000274: file pico-dev/source/hello-world.S, line 5.
        Note: automatically using hardware breakpoints for read-only addresses.
        ```
        
        ![img](/figures/Raspberry_Pi_Pico_development/2025-12-28-12-54-48-screenshot.png)
-   When stepping over the command `bl stdio_init_all`, GDB gets stuck and `openocd` server repeatedly reports:
    
    ```text
    rp2350.cm1] halted due to debug-request, current mode: Thread
    xPSR: 0x09000000 pc: 0x000000da msp: 0xf0000000
    ```
    
    This is caused by the fact that `stdio_init_all` is not step-safe.
    
    **Solution** Set a breakpoint after `bl stdio_init_all` and run `continue` in GDB to get there. For example, in the `hello-world` test case, we can break at line 9 in `hello-world.S`: `b hello-world.S:9`.

-   After debugging is finished and exiting from `gdb`, to let the program run normally, remove and reinsert the USB plug.


<a id="org26d6aa2"></a>

## Usage of GDB

{{ "2025-12-30-develop-pico-programs-on-raspberry-pi-or-linux" | backlink }}
