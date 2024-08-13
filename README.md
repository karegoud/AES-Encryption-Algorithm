# AES-Encryption-Algorithm
![image](https://github.com/user-attachments/assets/58a36cb5-189b-46e6-9643-278af93b52b5) <br>
This project is about 128-bit AES which encrypts data in fixed-size blocks of 128 bits, using multiple rounds of transformation.<br>
reg32_avalon_interface.v file has code how aes unit interact with nios processor using read and write signals from master (slave is aes unit).<br>
hello_world_small.c file has c code(software testbench) which is required to send write and read requests from master to slave. <br>
All other verilog files according to their name have code of different transformstions involved in AES encryption rounds.

