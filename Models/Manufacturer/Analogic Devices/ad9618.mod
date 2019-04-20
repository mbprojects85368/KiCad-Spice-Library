* AD9618 SPICE Macro-model                   12/90, Rev. A
*                                                 CLD    
*
* Copyright 1990 by Analog Devices, Inc.
*
* The information on this diskette is protected under the
* United States copyright laws.  Analog Devices, Inc.("ADI")
* hereby grants users of these macro-models hereto referred
* to as licensee, a nonexclusive, nontransferable license to
* use these macro-models as long as the licensee abides by
* the terms of this agreement.  Before using the macro-
* models the licensee should read this license.  If the
* licensee does not accept these terms, this diskette should
* be returned to ADI within 30 days.
*
* The licensee may not sell, load, rent, lease, or license
* the macro-models, in whole, in part, or in modified form,
* to anyone outside the licensee's company.  The licensee
* may modify these macro-models to suit his specific
* applications, and the licensee may make copies of this 
* diskette or macromodels for use within his company only.
*
* These macro-models are provided "AS IS, WHERE IS, AND WITH
* NO WARRANTY OF ANY KIND EITHER EXPRESSED OR IMPLIED, 
* INCLUDING BUT NOT LIMITED TO ANY IMPLIED WARRANTIES OF
* MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE."
* In no event will ADI be liable for special, collateral,
* incidental, or consequential damages in connection with or
* arising out of the use of these macro-models.  ADI
* reserves the right to make changes to the products and the
* macro-models without prior notice.
*
*
* Node assignments
*                non-inverting input
*                | inverting input
*                | | positive supply
*                | | |   negative supply
*                | | |   |   output
*                | | |   |   |
.SUBCKT AD9618   1 2 100 110 15 
* 1=VIN +, 2=VIN -, 100=VCC, 110=VEE, 15=VOUT
C1 12 5 .45P
C2 12 6 .45P
C3 12 2 0.2P
C5 5 0 1.25P
C6 6 0 1.25P
C7 12 0 1.25P
CINN 1 0 1.5P
CINI 2 0 1.5P
F1 100 13 VM1 1.2
F2 17 110 VM2 1.2
GM1 12 9 POLY(3) 0 5 0 6 5 6 1.6M,-4.0M,-4.0M
GM2 10 12 POLY(3) 0 6 0 5 6 5 1.6M,4.0M,4.0M
I1 100 3 DC 2.00M
I2 100 5 DC 3.00M
I3 4 110 DC 2.00M
I4 6 110 DC 3.29M
I5 100 12 5.0M
I6 12 110 5.0M
Q1 3 3 1 110 QNA 1.05
Q2 5 3 2 110 QNA 1.05
Q3 4 4 1 100 QPA 1.05
Q4 6 4 2 100 QPA 1.05
Q5 110 12 13 100 QPA .75
Q6A 100 13 14 110 QNB 1.05
Q6B 100 13 14 110 QNB 1.05
Q7 100 12 17 110 QNA .75
Q8A 110 17 16 100 QPB
Q8B 110 17 16 100 QPB
R1 12 0 20000
R2 14 15 6
R3 15 16 6
R4 100 5 120K
R5 5 0 14K
R6 6 110 450K
R7 6 0 4.5K
R8 7 20 280
VB1 5 7 DC 1.70
VB2 20 6 DC 1.70
VM1 100 10 DC 0
VM2 9 110 DC 0
*
.MODEL QNA NPN RB=75, IRB=0, RBM=7, RC=20, RE=0.7, IS=540E-18, 
+XTB=2.4, BF=380, IKF=15M, VAF=30, ISE=22E-16, 
+ISC=35E-21, TF=25P, CJE=16E-14, CJC=2.2E-13, XCJC=.2
+CJS=4E-13, MJS=0.3, VJE=1
*
.MODEL QNB NPN RB=24, IRB=0, RBM=2, RC=6, RE=0.5, IS=18E-16, 
+XTB=2, BF=380, IKF=49M, VAF=30, ISE=72E-16, 
+ISC=115E-21, TF=25P, CJE=54E-14, CJC=6E-13, XCJC=.2
+CJS=7E-13, MJS=0.3, VJE=1
*
.MODEL QPA PNP RB=83, IRB=0M, RBM=14, RC=18, RE=0.5, IS=26E-17, 
+XTB=2, BF=190, IKF=24M, VAF=15, ISE=7E-15, 
+ISC=30E-19, TF=35P, CJE=11E-14, CJC=3.1E-13, XCJC=.2
+CJS=9E-13, MJS=0.35, VJE=1
*
.MODEL QPB PNP RB=25, IRB=0, RBM=4, RC=5, RE=0.2, IS=88E-17,
+XTB=2, BF=190, IKF=84E-3, VAF=15, ISE=22.3E-15, 
+ISC=100E-19, TF=35P, CJE=36E-14, CJC=8.5E-13, XCJC=.2
+CJS=1.4E-12, MJS=0.35, VJE=1
* 
.ENDS AD9618   
*
*
**** MACRO18 TEST CIRCUIT **********************
*
*VCC 5 0 DC 5 AC 0
*VEE 6 0 DC -5 AC 0
*V3 2 7 DC 0
*RFB 4 2 1000
*RFF 1 2 110
*RL 4 0 100                                  
*
*X1 3 7 5 6 4 AD9618
* 3=VIN +, 7=VIN -, 5=VCC, 6=VEE, 4=VOUT
*
*V1 1 0 DC 0 AC 0 
*V2 3 0 DC 0 AC 1
*.AC DEC 101 10K 1G                         
*.PLOT AC VDB(4) IDB(V3) VP(4) IP(V3) I(V3)
*
*V2 3 0 DC 0 AC 1 PULSE -.1 .1 5N .4N .4N 30N 65N
*.TRAN .05N 65N
*.PLOT TRAN V(4) V(2)
*
*V2 3 0 DC 0 AC 1 0 SIN(0 0.1 20MEG 0 0)
*.TRAN .2N 65N
*.FOUR 20MEG V(4)
*.PLOT TRAN V(4)
*.END
