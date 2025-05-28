# ARM Assembly Text & Number Converter

This project is a command-line interactive tool written entirely in ARM Assembly for Raspberry Pi. It allows users to convert input between text and various numeric formats (ASCII, binary, hexadecimal) and vice versa. The system showcases robust input handling, modular function design, and low-level control flow through subroutine-based execution.

---

## 🔧 Features

- Interactive text-based menu interface
- Conversion modes:
  - Text to ASCII
  - Text to Binary
  - Text to Hexadecimal
  - Number to ASCII
  - Number to Binary
  - Number to Hexadecimal
- Custom division subroutine for binary conversion
- Robust input validation (e.g., ASCII range checking, digit verification)
- Manual memory handling via registers and `.space` buffers
- Fully modular: Each function exists in its own `.s` file and is invoked via BL calls

---

## 📁 File Overview

| File               | Description |
|--------------------|-------------|
| `converter.s`      | Main entrypoint and interactive menu |
| `text_to_ascii.s`  | Converts each character to ASCII decimal |
| `text_to_binary.s` | Converts each character to binary string |
| `text_to_hex.s`    | Converts each character to hexadecimal |
| `num_to_ascii.s`   | Converts valid ASCII number to character |
| `num_to_binary.s`  | Converts decimal number to binary string |
| `num_to_hex.s`     | Converts decimal number to hexadecimal |
| `divide.s`         | Custom long division routine used in binary conversion |

---

## 💡 Why It’s Impressive

This project demonstrates hands-on expertise in:

- **Low-level memory operations**
- **Subroutine design and parameter passing in ARM**
- **Interactive CLI design in Assembly**
- **Integer parsing and validation**
- **Custom algorithm implementation (e.g., long division)**

---

## 🛠️ How to Run (on Raspberry Pi or ARM emulator)

1. Assemble all files with:
    ```bash
    as -o converter.o converter.s
    ```
    Repeat for each subroutine `.s` file.

2. Link:
    ```bash
    ld -o converter converter.o <other object files>
    ```

3. Run:
    ```bash
    ./converter
    ```

---

## 📌 Note

Ensure you are compiling and running this on a Raspberry Pi or ARM-compatible environment. The code uses `SWI` instructions for system calls, which are platform-specific.

---

## 📜 License

MIT License