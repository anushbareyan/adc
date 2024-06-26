## Analog-to-Digital Converter in Verilog

This repository contains Verilog code implementing an Analog-to-Digital Converter (ADC) using a voltage divider, comparators, and a priority encoder. The ADC converts an analog input voltage into a 3-bit digital output.

## Overview

The main components of this ADC implementation are:

1. **Voltage Divider Module (`voltage_divider8`)**: 
    - Generates 8 different voltage levels from a given input voltage `v_in`.
    - The output voltages are evenly divided across 8 outputs (`v_out[0:7]`).

2. **Comparator Module (`comparator`)**: 
    - Compares the input voltage with each voltage level generated by the voltage divider.
    - Outputs a binary signal indicating whether the input voltage is less than the compared voltage.

3. **Priority Encoder Module (`prior_encoder8x3`)**: 
    - Takes the comparator outputs and encodes the highest-priority active input into a 3-bit binary code.

4. **ADC Module (`adc1x3`)**: 
    - Combines the voltage divider, comparators, and priority encoder to create a 3-bit ADC.
    - Takes an analog input voltage and outputs the corresponding 3-bit digital code.

5. **Testbench**:
    - Tests the functionality of the voltage divider, comparator, priority encoder, and ADC modules.
    - Displays the output voltages of the voltage divider.
    - Displays the encoded output from the priority encoder.
    - Iterates through a range of analog input voltages for the ADC and displays the resulting digital output.

## Usage

To test and verify the functionality of the ADC, compile and run the provided Verilog testbench (`test` module). The testbench will simulate the ADC operation and output the results for different analog inputs.
