# 🎮 FPGA VGA Tic-Tac-Toe Game (Basys 3)

## 📌 Project Overview
This project implements a **Tic-Tac-Toe game using Verilog HDL** on the **Basys 3 FPGA (Artix-7)** with **VGA display output**.

It demonstrates real-time graphics rendering, hardware-based game logic, and user interaction using physical switches.

> 📄 Based on project report

---

## 🚀 Features
- 🎯 2-player Tic-Tac-Toe game  
- 🖥️ VGA output (640×480 @ 60Hz)  
- 🔄 Real-time rendering using FPGA  
- 🎮 Switch-based user input  
- 🧠 Finite State Machine (FSM) game logic  
- 🏆 Automatic win detection  
- 🔴 Winning cells highlighted  
- 🔒 Game locks after win  

---

## 🧱 System Architecture

### 🔹 Modules
- **VGA Sync (`vga_sync.v`)**  
  Generates HSYNC, VSYNC signals and pixel coordinates  

- **Cell FSM (`Cell.v`)**  
  Each grid cell acts as a state machine (Empty, X, O)  

- **Game State (`gameState.v`)**  
  Detects win conditions (rows, columns, diagonals)  

- **Pixel Generator (`videoElements.v`)**  
  Draws grid and player moves on VGA screen  

- **Top Module (`gameLogic.v`)**  
  Integrates all components and controls gameplay  

---

## 🎮 How It Works

1. The FPGA generates VGA signals for display  
2. A 3×3 grid is drawn on the monitor  
3. Players use switches to place moves  
4. FSM updates each cell state  
5. Game logic checks for winning conditions  
6. Winning cells turn **RED**, and game stops  

---

## 🖥️ Hardware Requirements

- 🧩 Basys 3 FPGA Board (Artix-7)
- 🖥️ VGA Monitor
- 🔌 VGA Cable
- 🔗 USB Cable (for programming)

---

## 🛠️ Software Tools

- **Xilinx Vivado Design Suite (2020 or later)**
- Verilog HDL

---

## 🔌 Input Mapping (Switches)

| Position        | Switch |
|----------------|--------|
| Top-Left       | SW2    |
| Top-Middle     | SW1    |
| Top-Right      | SW0    |
| Middle-Left    | SW5    |
| Center         | SW4    |
| Middle-Right   | SW3    |
| Bottom-Left    | SW8    |
| Bottom-Middle  | SW7    |
| Bottom-Right   | SW6    |

---

## 🎨 Output Behavior

- ⚪ Grid → White  
- 🔵 Player 1 → Cyan  
- 🟡 Player 2 → Yellow  
- 🔴 Winner → Red  
- 💡 LED → ON when win detected  

---

## 📽️ Demo Video (Dropdown)

<details>
<summary>👉 Click to watch practical demo</summary>

🔗 https://drive.google.com/drive/folders/1ArRcDDIFP6an6jBGKnkaD83WkULUfwJk?usp=sharing

</details>

---

## 📊 Simulation

- Verified using testbench (`tb_gameLogic`)
- FSM transitions correctly between players  
- Win detection works independently of VGA timing  

---

## 📁 Project Structure
