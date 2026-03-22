import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer

@cocotb.test()
async def test_alu(dut):
    # Start the clock (10MHz)
    clock = Clock(dut.clk, 100, units="ns")
    cocotb.start_soon(clock.start())

    # Reset the design
    dut._log.info("Resetting ALU...")
    dut.rst_n.value = 0
    await Timer(200, units="ns")
    dut.rst_n.value = 1
    dut.ena.value = 1
    await RisingEdge(dut.clk)

    # Test Case 1: Addition (OpCode 000)
    # ui_in = [OpCode(3 bits) | A(5 bits)]
    # We want Op 000, A = 5, B = 10 -> Result should be 15
    dut.ui_in.value = (0b000 << 5) | 5
    dut.uio_in.value = 10
    await RisingEdge(dut.clk)
    await Timer(1, units="ns") # Small delay to let signals settle
    assert int(dut.uo_out.value) == 15
    dut._log.info("Addition test passed!")

    # Test Case 2: Bitwise AND (OpCode 010)
    # Op 010, A = 0b11111 (31), B = 0b00001 (1) -> Result should be 1
    dut.ui_in.value = (0b010 << 5) | 31
    dut.uio_in.value = 1
    await RisingEdge(dut.clk)
    await Timer(1, units="ns")
    assert int(dut.uo_out.value) == 1
    dut._log.info("AND logic test passed!")

    # Test Case 3: Left Shift (OpCode 110)
    # Op 110, A = 4, B = 0 (ignored) -> Result should be 8
    dut.ui_in.value = (0b110 << 5) | 4
    await RisingEdge(dut.clk)
    await Timer(1, units="ns")
    assert int(dut.uo_out.value) == 8
    dut._log.info("Shift test passed!")
