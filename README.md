# CPE 233 Computer Design and Assembly Language Programming

## Description

This repository contains the source code for the labs and projects for CPE 233 Computer Design and Assembly Language Programming at Cal Poly, San Luis Obispo. In this class, a Riscv32i processor was designed and implemented in System Verilog using a Basys 3 Board. The processor was then used to run assembly language programs. 

Professor - Paul Hummel (phummel@calpoly.edu)

## Hardware Assignments

The hardware assignments were designed to build the processor from the ground up. Each assignment is built on the previous one. The assignments were as follows:

[x] Hardware Assignment 1 - Program ROM and Assembly Programming
[x] Hardware Assignment 2 - Program Counter
[o] Hardware Assignment 3 - Register File
[o] Hardware Assignment 4 - Arithmetic Logic Unit and Immediate Generator
[o] Hardware Assignment 5 - Real Memory and Branch Generator
[o] Hardware Assignment 6 - Control Unit
[o] Hardware Assignment 7 - OTTER Wrapper
[o] Hardware Assignment 8 - Interrupts and Button Bounce

## Extra Work for Each Assignment

### Hardware Assignment 1

I learned how to load a `.mem` file into a simulation environment using the ```$readmemh``` function. From there I was able to write a program that could iterate through the memory and verify that the ProgROM was working.

### Hardware Assignment 2

I started diving deeper into a more robust way of testing. Starting by doing some research on a proper testbench setup. While learning about interfaces, I decided to not integrate them into this project but rather used some ```$random``` calls to generate random test cases and then verify the results. I also used many different tasks and the ```#finish``` command to make sure that the testbench was running correctly.
