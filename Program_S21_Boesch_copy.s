                  //KENDALL BOECH
                  // PROFESSOR ALFORD 
                  // CS 2240 
                  // PROGRAM 3
                  // 13 APRIL 2021
                  
                  //THIS IS THE ASSEMBLY (.S) FILE ASSOCIATED WITH PROGRAM 3
                  // THIS FILE HOLDS THE DATA TABLE AS WELL AS THE FOUR EXTERNAL 
                  // SUBROUTINES UTILIZED IN THE MAIN PROGRAM (.CPP FILE)
                  
                  
                  
                    AREA Prog3, CODE, READONLY
 
// NAMING REGISTERS FOR MORE CLEAR CALCULATION                    
MAX                 RN 3    // R3
SUM_FREQ            RN 4    // R4
CURR_W              RN 5    // R5
CURR_F              RN 8    // R6


//DATA TABLE UTILIZED IN EXECUTION 
table               DCB "pears", 0      // 0 TERMINATOR FOR ALL STRINGS 
                    DCD 8               // FREQUENCIES 
                    DCB "appleS", 0
                    DCD 16
                    DCB "pie", 0
                    SPACE 4
                    DCD 30
                    DCB "beans", 0
                    DCD 12
                    DCD 0           // ZERO TERMINATOR FOR TABLE - INDICATES NO MORE ROWS
             
             
             
 //COUNT ITEMS ITERATES THROUGH THE TABLE EVERY 12 BITS AND
 //COUNTS HOW MANY TIMES IT CAN DO THIS BEFORE REACHING 
 // ZERO (THE NULL TERMINATOR)                    
                    GLOBAL CountItems
CountItems 
                    MOV MAX, #0             //ENSURE MAX VARIABLE BEGINS AT 0
                    ADR R0, table           // LOAD TABLE ADDRESS INTO R0
top                 LDR R1, [R0]            // LOAD FIRST INDEX CHAR  OF FIRST WORD INTO R1
                    CBZ R1, done            // IF R1 == 0 BRANCH TO 'done'
                    ADD MAX, MAX, #1        //IF NOT, INCREMENT MAX BY ONE 
                    ADD R0, R0, #12         // INCREMENT R0 BY 12 TO REACH FIRST INDEX OF NEXT ELEMENT 
                    B top                   // LOOP BACK TO TOP 
done                MOV R0, MAX             // ONCE COMPLETE, MOVE MAX INTO R0 AND EXIT BRANCH
                    BX LR
                
 //SUM ALL FREQUENCEIS ITERATES THROUGH THE DATA TABLE AND 
 // ADDS TOGETHER THE FREQUENCIES OF ALL WORDS                
                   GLOBAL SumAllFrequencies
                
SumAllFrequencies  
                   MOV SUM_FREQ, #0         //ENSURE SUM_FREQ VARIABLE BEGINS AT 0 
                   ADR R0, table            // LOAD ADDRESS OF TABLE INTO R0 
                   LDR R1, [R0]             // LOAD VALUE OF ADDRESS IN R0 INTO R1
L1                 LDR R1, [R0, #8]         // MOVE UP 8 BITS TO SKIP WORD & REACH FREQUENCY
                   CBZ R1, L2               // ENSURE THE VALUE OF R1 DOES NOT EQUAL ZERO, IF DOES BRANCH TO L2
                   ADD SUM_FREQ, SUM_FREQ, R1       // IF NOT, ADD THE VALUE TO THE TOTAL SUM
                   ADD R0, R0, #4           // R0 NOW POINTS TO THE FIRST INDEX OF THE NEXT WORD
                   B L1                         
L2                 MOV R0, SUM_FREQ         // LOAD FINAL FREQUENCY SUM VALUE IN RO
                   BX LR                    
                   
//GET WORD AT TAKES IN AN INTEGER & RETURNS THE 
//ADDRESS OF THE FIRST BIT OF THE STRING AT THAT INDEX                    
                   GLOBAL GetWordAt
            
GetWordAt          MOV CURR_W, R0            // index i moved into R5
                   ADR R0, table                //LOAD TABLE ADDRESS INTO R0
                   LDR R1, [R0]               // addy of word at index [0] 
                   MOV R7, #12                 // LOAD 12 INTO R7 -- TO BE USED FOR ARRAY TRAVERSAL 
                   MUL R6, CURR_W, R7       // R6 NOW HOLD 12 TIMES THE ADDRESS OF THE WORD REQUESTED
                   LDR CURR_W, [R6]         // LOAD ADDRESS 
                   MOV R0, CURR_W           // LOAD ADDRESS OF WORD INTO R0
                   BX LR
                   
 // GET FREQ AT TAKES IN AN INTEGER & RETURNS THE FREQUENCY 
 // OF THAT WORD                     
                   GLOBAL GetFreqAt
                   
GetFreqAt         MOV CURR_F, R0            //INDECX I MOVED INTO R8
                  ADR R0, table             //LOAD ADDRESS OF TABLE INTO R0
                  LDR R1, [R0, #8]          // LOAD VALUE OF ADDRESS R0 + 8 INTO R1
                  MOV R7, #12               // LOAD 12 INTO R17 
                  MUL R9, CURR_F, R7        //R9 HOLDS PRODUCT OF FREQUENCY INDEX * 12
                  LDR CURR_F, [R7]          //LOAS VALUE OF R7 INTO CUR_F
                  MOV R0, CURR_F            // LOAD FINAL VALUE INTO R0
                  BX LR
                   
    
                
                   
                   
     

                    
                
                


                    END