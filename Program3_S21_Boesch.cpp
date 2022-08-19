// Kendall Boesch
// Professor Alford 
// CS 2240 
// Program 3
// 13 April 2021

//THIS PROGRAM READS A TABLE OF WORDS AND FREQUENCIES.
// IT THEN CALCULATES THE PERCENTAGE OF ALL WORDS EACH
// INIVIDUAL WORD ACCOUNTS FOR AND CREATES A DISPLAY
// ON THE LCD SCREEN THAT REPRESENTS THE DIFFERENT FREQUENCIES




//header files needed to include for execution 
#include "mbed.h"
#include "LCD_DISCO_F429ZI.h"

    // FUNCTIONS LOCATED IN .S FILE (ASSEMBLY)
extern "C" int32_t CountItems(); 
extern "C" int32_t SumAllFrequencies(); 
extern "C" uint8_t * GetWordAt(int32_t i); 
extern "C" uint16_t GetFreqAt(int32_t i); 


LCD_DISCO_F429ZI lcd; 

DigitalOut led1(LED1);
InterruptIn user_button(USER_BUTTON);
//Button Pressed Function
// upon button press iterates through table & retrieves 
// word at index [i] & displays it on line 1 + i
//
void button_pressed()
{
    lcd.Clear(LCD_COLOR_RED);               // SET LCD DCREEN TO RED
    for (int i = 0; i < 4; i++)
        {
            uint8_t * word = GetWordAt(i);      //Call Get Word At Method 
                        
            lcd.DisplayStringAt(0, LINE(1+i), (uint8_t *) &word, CENTER_MODE);      // display string with word 
            
        }
}
void button_released()              // button released function - no use in this prog, but still need if using buttons 
{ 
}

int main()
{ 

    led1 = 1;
    
    //initialize button actions 
    user_button.rise(&button_pressed);
    user_button.fall(&button_released); 
    
    //initialize table property variables 
    int MAX = CountItems(); 
    int Total_Frequency = SumAllFrequencies(); 

    //set display preferences 
    lcd.Clear(LCD_COLOR_GREEN);
    lcd.SetTextColor(LCD_COLOR_ORANGE);

    while (1)       //enter while loop
    {        
        
        for (int i = 0; i < 4; i++)         //enter for loop
        {
            uint8_t * word = GetWordAt(i);          //call getWordAt function for word at index i -- returns address of first char
            int16_t frequency = GetFreqAt(i);       // call getFreqAt function for frequency at index i 
            int16_t percentage = frequency/Total_Frequency;         // calculate percentage of total words wordAt(i) accounts for 
            
            if (i == 0)                             // if i is 0, set color to dark magenta
            {
                lcd.SetTextColor(LCD_COLOR_DARKMAGENTA); 
            }
            else if (i == 1)                        // if i is 1 set color to cyan
            {
                lcd.SetTextColor(LCD_COLOR_CYAN); 
            }
            else if (i == 2)                    // if i is 2 set color ro red
            {
                lcd.SetTextColor(LCD_COLOR_RED); 
            }
            else                                // else set color to yellow
            {
                lcd.SetTextColor(LCD_COLOR_YELLOW);
            } 
            
            lcd.FillCircle(i*10+1, i*10+1, 100*percentage); //draw circle on screen starting at (i*10+1, i*10+1) with a radius of 100*percentage 
            
                 
        } 
    }
    return 0; 

}