
#include "keyboard.h"



KeyboardDriver::KeyboardDriver(InterruptManager* manager)
: InterruptHandler(0x21, manager),
dataport(0x60),
commandport(0x64)
{

}

KeyboardDriver::~KeyboardDriver()
{
}

uint32_t KeyboardDriver::HandleInterrupt(uint32_t esp)
{
    return esp;
}