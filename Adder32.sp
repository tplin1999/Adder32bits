*** 32bits adder ***
.param l_min = 90n
.param w_min = 0.2u
.param w_p = 3*w_min
.param w_n = 1*w_min

.subckt	inv	in	out	vdd
mp0	out	in	vdd	vdd	pmos	l=l_min  w=w_p
mn0  	out  	in  	gnd  	gnd  	nmos  	l=l_min  w=w_n
.ends

.subckt or	a       b       out	vdd
mp0  	net1  	a  	vdd  	vdd  	pmos  	l=l_min  w=w_p
mp1  	outb  	b  	net1  	vdd  	pmos  	l=l_min  w=w_p
mn0  	outb  	a  	gnd  	gnd  	nmos  	l=l_min  w=w_n
mn1  	outb  	b  	gnd  	gnd  	nmos  	l=l_min  w=w_n
xinv0	outb	out	vdd	inv
.ends

.subckt and	a       b       out	vdd
mp0  	outb  	a  	vdd  	vdd  	pmos  	l=l_min  w=w_p
mp1  	outb  	b  	vdd  	vdd  	pmos  	l=l_min  w=w_p
mn0  	outb  	a  	net1  	gnd  	nmos  	l=l_min  w=w_n
mn1  	net1  	b  	gnd  	gnd  	nmos  	l=l_min  w=w_n
xinv0	outb	out	vdd	inv
.ends

.subckt exor	a       b       out	vdd
xinv0   a	a_b	vdd     inv
xinv1   b	b_b	vdd     inv
mp0  	pt1  	a_b  	vdd  	vdd  	pmos  	l=l_min  w=w_p
mp1  	pt1  	b  	vdd  	vdd  	pmos  	l=l_min  w=w_p
mp2  	outb  	a  	pt1  	vdd  	pmos  	l=l_min  w=w_p
mp3  	outb  	b_b  	pt1  	vdd  	pmos  	l=l_min  w=w_p
mn0  	outb  	a  	net1  	gnd  	nmos  	l=l_min  w=w_n
mn1  	net1  	b_b  	gnd  	gnd  	nmos  	l=l_min  w=w_n
mn2  	outb  	a_b  	net2  	gnd  	nmos  	l=l_min  w=w_n
mn3  	net2  	b  	gnd  	gnd  	nmos  	l=l_min  w=w_n
xinv2	outb	out	vdd	inv
.ends

.subckt	tgadd	Cimi1	Pi	Pi_b	Gi_b	Si	Ci	vdd
mn0     Cimi1   Pi     	Ci	gnd     nmos  	l=l_min w=w_n
mp0     Cimi1   Pi_b    Ci    	vdd     pmos	l=l_min	w=w_p

mp1     Ci   	Gi_b    vdd    	vdd     pmos	l=l_min	w=w_p

mn1     Ci   	Gi_b    nt1	gnd     nmos  	l=l_min w=w_n
mn2     nt1   	Pi_b    gnd	gnd     nmos  	l=l_min w=w_n

xexor1	Pi	Cimi1	Si	vdd	exor
.ends

.subckt	manch	Cmi1	A0	A1	A2	A3	B0	B1	B2	B3	S0	S1	S2	S3	C3	vdd
xexor0	A0	B0	P0	vdd	exor
xexor1	A1	B1	P1	vdd	exor
xexor2	A2	B2	P2	vdd	exor
xexor3	A3	B3	P3	vdd	exor
xinv0   P0	P0_b	vdd     inv
xinv1   P1	P1_b	vdd     inv
xinv2   P2	P2_b	vdd     inv
xinv3   P3	P3_b	vdd     inv

xand0	A0	B0	G0	vdd	and
xand1	A1	B1	G1	vdd	and
xand2	A2	B2	G2	vdd	and
xand3	A3	B3	G3	vdd	and
xinv4   G0	G0_b	vdd     inv
xinv5   G1	G1_b	vdd     inv
xinv6   G2	G2_b	vdd     inv
xinv7   G3	G3_b	vdd     inv

xtgadd0	Cmi1	P0	P0_b	G0_b	S0	C0	vdd	tgadd
xtgadd1	C0	P1	P1_b	G1_b	S1	C1	vdd	tgadd
xtgadd2	C1	P2	P2_b	G2_b	S2	C2	vdd	tgadd
xtgadd3	C2	P3	P3_b	G3_b	S3	C3_t	vdd	tgadd

xjmp0_3	P0	P1	P2	P3	jmp0_3	vdd	and4
xinv8	jmp0_3	jmp0_3b	vdd	inv

mn0     Cmi1	jmp0_3  C3	gnd     nmos  	l=l_min w=w_n
mp0     Cmi1	jmp0_3b C3    	vdd     pmos	l=l_min	w=w_p
mn1     C3_t   	jmp0_3b C3	gnd     nmos  	l=l_min w=w_n
mp1     C3_t   	jmp0_3  C3    	vdd     pmos	l=l_min	w=w_p
.ends

.subckt and4	a       b	c	d	out	vdd
mp0  	outb  	a  	vdd  	vdd  	pmos  	l=l_min	w=w_p
mp1  	outb  	b  	vdd  	vdd  	pmos  	l=l_min	w=w_p
mp2  	outb  	c  	vdd  	vdd  	pmos  	l=l_min	w=w_p
mp3  	outb  	d  	vdd  	vdd  	pmos  	l=l_min	w=w_p
mn0  	outb  	a  	net1  	gnd  	nmos  	l=l_min	w=w_n
mn1  	net1  	b  	net2  	gnd  	nmos  	l=l_min	w=w_n
mn2  	net2  	c  	net3  	gnd  	nmos  	l=l_min	w=w_n
mn3  	net3  	d  	gnd  	gnd  	nmos  	l=l_min	w=w_n
xinv0	outb	out	vdd	inv
.ends

.subckt ADDER32 vdd 
+ A0 A1 A2 A3 A4 A5 A6 A7 A8 A9 A10 A11 A12 A13 A14 A15 A16
+ A17 A18 A19 A20 A21 A22 A23 A24 A25 A26 A27 A28 A29 A30 A31
+ B0 B1 B2 B3 B4 B5 B6 B7 B8 B9 B10 B11 B12 B13 B14 B15 B16
+ B17 B18 B19 B20 B21 B22 B23 B24 B25 B26 B27 B28 B29 B30 B31
+ Cmi1 C31
+ S0 S1 S2 S3 S4 S5 S6 S7 S8 S9 S10 S11 S12 S13 S14 S15 S16
+ S17 S18 S19 S20 S21 S22 S23 S24 S25 S26 S27 S28 S29 S30 S31
xmanch0	Cmi1	A0	A1	A2	A3	B0	B1	B2	B3	S0	S1	S2	S3	C3	vdd	manch
xmanch1	C3	A4	A5	A6	A7	B4	B5	B6	B7	S4	S5	S9	S10	C7	vdd	manch
xmanch2	C7	A8	A9	A10	A11	B8	B9	B10	B11	S8	S9	S10	S11	C11	vdd	manch
xmanch3	C11	A12	A13	A14	A15	B12	B13	B14	B15	S12	S13	S14	S15	C15	vdd	manch
xmanch5	C15	A16	A17	A18	A19	B16	B17	B18	B19	S16	S17	S18	S19	C19	vdd	manch
xmanch6	C19	A20	A21	A22	A23	B20	B21	B22	B23	S20	S21	S22	S23	C23	vdd	manch
xmanch7	C23	A24	A25	A26	A27	B24	B25	B26	B27	S24	S25	S26	S27	C27	vdd	manch
xmanch8	C27	A28	A29	A30	A31	B28	B29	B30	B31	S28	S29	S30	S31	C31	vdd	manch

c0	S0	gnd	10f
c1	S1	gnd	10f
c2	S2	gnd	10f
c3	S3	gnd	10f
c4	S4	gnd	10f
c5	S5	gnd	10f
c6	S6	gnd	10f
c7	S7	gnd	10f
c8	S8	gnd	10f
c9	S9	gnd	10f
c10	S10	gnd	10f
c11	S11	gnd	10f
c12	S12	gnd	10f
c13	S13	gnd	10f
c14	S14	gnd	10f
c15	S15	gnd	10f
c16	S16	gnd	10f
c17	S17	gnd	10f
c18	S18	gnd	10f
c19	S19	gnd	10f
c20	S20	gnd	10f
c21	S21	gnd	10f
c22	S22	gnd	10f
c23	S23	gnd	10f
c24	S24	gnd	10f
c25	S25	gnd	10f
c26	S26	gnd	10f
c27	S27	gnd	10f
c28	S28	gnd	10f
c29	S29	gnd	10f
c30	S30	gnd	10f
c31	S31	gnd	10f
.ends

*** main ***
VDD     vdd	gnd     dc=1V

VCmi1  	Cmi1	gnd     dc=0V

VA0 	A0 	gnd 	PWL	(0n 0v 100p 0v 150p 1v)
VA1	A1    	gnd    	dc=0v
VA2	A2    	gnd    	dc=0v
VA3	A3    	gnd    	dc=0v
VA4 	A4 	gnd 	dc=0v
VA5	A5    	gnd    	dc=0v
VA6	A6    	gnd    	dc=0v
VA7	A7    	gnd    	dc=0v
VA8	A8    	gnd    	dc=0v
VA9	A9    	gnd    	dc=0v
VA10	A10    	gnd    	dc=0v
VA11	A11 	gnd 	dc=0v
VA12	A12    	gnd    	dc=0v
VA13	A13    	gnd    	dc=0v
VA14	A14    	gnd    	dc=0v
VA15	A15    	gnd    	dc=0v
VA16	A16    	gnd    	dc=0v
VA17	A17    	gnd    	dc=0v
VA18 	A18 	gnd 	dc=0v
VA19	A19    	gnd    	dc=0v
VA20	A20    	gnd    	dc=0v
VA21	A21    	gnd    	dc=0v
VA22	A22    	gnd    	dc=0v
VA23	A23    	gnd    	dc=0v
VA24	A24    	gnd    	dc=0v
VA25	A25 	gnd 	dc=0v
VA26	A26    	gnd    	dc=0v
VA27	A27    	gnd    	dc=0v
VA28	A28    	gnd    	dc=0v
VA29	A29    	gnd    	dc=0v
VA30	A30    	gnd    	dc=0v
VA31	A31    	gnd    	dc=0v

VB0     B0	gnd     dc=1V
VB1     B1	gnd     dc=1V
VB2     B2	gnd     dc=1V
VB3     B3	gnd     dc=1V
VB4     B4	gnd     dc=1V
VB5     B5	gnd     dc=1V
VB6     B6	gnd     dc=1V
VB7     B7	gnd     dc=1V
VB8     B8	gnd     dc=1V
VB9     B9	gnd     dc=1V
VB10    B10	gnd     dc=1V
VB11    B11	gnd     dc=1V
VB12    B12	gnd     dc=1V
VB13    B13	gnd     dc=1V
VB14    B14	gnd     dc=1V
VB15    B15	gnd     dc=1V
VB16    B16	gnd     dc=1V
VB17    B17	gnd     dc=1V
VB18    B18	gnd     dc=1V
VB19    B19	gnd     dc=1V
VB20    B20	gnd     dc=1V
VB21    B21	gnd     dc=1V
VB22    B22	gnd     dc=1V
VB23    B23	gnd     dc=1V
VB24    B24	gnd     dc=1V
VB25    B25	gnd     dc=1V
VB26    B26	gnd     dc=1V
VB27    B27	gnd     dc=1V
VB28    B28	gnd     dc=1V
VB29    B29	gnd     dc=1V
VB30    B30	gnd     dc=1V
VB31    B31	gnd     dc=0V

XADD	vdd 
+ A0 A1 A2 A3 A4 A5 A6 A7 A8 A9 A10 A11 A12 A13 A14 A15 A16
+ A17 A18 A19 A20 A21 A22 A23 A24 A25 A26 A27 A28 A29 A30 A31
+ B0 B1 B2 B3 B4 B5 B6 B7 B8 B9 B10 B11 B12 B13 B14 B15 B16
+ B17 B18 B19 B20 B21 B22 B23 B24 B25 B26 B27 B28 B29 B30 B31
+ Cmi1 C31
+ S0 S1 S2 S3 S4 S5 S6 S7 S8 S9 S10 S11 S12 S13 S14 S15 S16
+ S17 S18 S19 S20 S21 S22 S23 S24 S25 S26 S27 S28 S29 S30 S31
+ / ADDER32



*** setting ***
.tran 0.01ns 15ns start=0

.options POST=2
.options AUTOSTOP
.options INGOLD=2     DCON=1
.options GSHUNT=1e-12 RMIN=1e-15
.options ABSTOL=1e-5  ABSVDC=1e-4
.options RELTOL=1e-2  RELVDC=1e-2
.options NUMDGT=4 PIVOT=13
.options runlvl=6
.temp 40


*** power consumption ***
.meas tran T1 when V(A0)=0.5 rise=1
.meas tran T2 when V(S31)=0.5 rise=1
.meas Td param="T2-T1" 
.meas tran Power avg p(XADD) from T1 to T2
.meas Score param="((10^(-9))/(Td*Power))"


*** library ***
* PTM 90nm NMOS 
.model  nmos  nmos  level = 54

+version = 4.0          binunit = 1            paramchk= 1            mobmod  = 0          
+capmod  = 2            igcmod  = 1            igbmod  = 1            geomod  = 1          
+diomod  = 1            rdsmod  = 0            rbodymod= 1            rgatemod= 1          
+permod  = 1            acnqsmod= 0            trnqsmod= 0          

+tnom    = 27           toxe    = 2.05e-9      toxp    = 1.4e-9       toxm    = 2.05e-9   
+dtox    = 0.65e-9      epsrox  = 3.9          wint    = 5e-009       lint    = 7.5e-009   
+ll      = 0            wl      = 0            lln     = 1            wln     = 1          
+lw      = 0            ww      = 0            lwn     = 1            wwn     = 1          
+lwl     = 0            wwl     = 0            xpart   = 0            toxref  = 2.05e-9   
+xl      = -40e-9
+vth0    = 0.397        k1      = 0.4          k2      = 0.01         k3      = 0          
+k3b     = 0            w0      = 2.5e-006     dvt0    = 1            dvt1    = 2       
+dvt2    = -0.032       dvt0w   = 0            dvt1w   = 0            dvt2w   = 0          
+dsub    = 0.1          minv    = 0.05         voffl   = 0            dvtp0   = 1.2e-009     
+dvtp1   = 0.1          lpe0    = 0            lpeb    = 0            xj      = 2.8e-008   
+ngate   = 2e+020       ndep    = 1.94e+018    nsd     = 2e+020       phin    = 0          
+cdsc    = 0.0002       cdscb   = 0            cdscd   = 0            cit     = 0          
+voff    = -0.13        nfactor = 1.7          eta0    = 0.0074       etab    = 0          
+vfb     = -0.55        u0      = 0.0547       ua      = 6e-010       ub      = 1.2e-018     
+uc      = -3e-011      vsat    = 113760       a0      = 1.0          ags     = 1e-020     
+a1      = 0            a2      = 1            b0      = -1e-020      b1      = 0          
+keta    = 0.04         dwg     = 0            dwb     = 0            pclm    = 0.06       
+pdiblc1 = 0.001        pdiblc2 = 0.001        pdiblcb = -0.005       drout   = 0.5        
+pvag    = 1e-020       delta   = 0.01         pscbe1  = 8.14e+008    pscbe2  = 1e-007     
+fprout  = 0.2          pdits   = 0.08         pditsd  = 0.23         pditsl  = 2.3e+006   
+rsh     = 5            rdsw    = 180          rsw     = 90           rdw     = 90        
+rdswmin = 0            rdwmin  = 0            rswmin  = 0            prwg    = 0          
+prwb    = 6.8e-011     wr      = 1            alpha0  = 0.074        alpha1  = 0.005      
+beta0   = 30           agidl   = 0.0002       bgidl   = 2.1e+009     cgidl   = 0.0002     
+egidl   = 0.8          

+aigbacc = 0.012        bigbacc = 0.0028       cigbacc = 0.002     
+nigbacc = 1            aigbinv = 0.014        bigbinv = 0.004        cigbinv = 0.004      
+eigbinv = 1.1          nigbinv = 3            aigc    = 0.012        bigc    = 0.0028     
+cigc    = 0.002        aigsd   = 0.012        bigsd   = 0.0028       cigsd   = 0.002     
+nigc    = 1            poxedge = 1            pigcd   = 1            ntox    = 1          

+xrcrg1  = 12           xrcrg2  = 5          
+cgso    = 1.9e-010     cgdo    = 1.9e-010     cgbo    = 2.56e-011    cgdl    = 2.653e-10     
+cgsl    = 2.653e-10    ckappas = 0.03         ckappad = 0.03         acde    = 1          
+moin    = 15           noff    = 0.9          voffcv  = 0.02       

+kt1     = -0.11        kt1l    = 0            kt2     = 0.022        ute     = -1.5       
+ua1     = 4.31e-009    ub1     = 7.61e-018    uc1     = -5.6e-011    prt     = 0          
+at      = 33000      

+fnoimod = 1            tnoimod = 0          

+jss     = 0.0001       jsws    = 1e-011       jswgs   = 1e-010       njs     = 1          
+ijthsfwd= 0.01         ijthsrev= 0.001        bvs     = 10           xjbvs   = 1          
+jsd     = 0.0001       jswd    = 1e-011       jswgd   = 1e-010       njd     = 1          
+ijthdfwd= 0.01         ijthdrev= 0.001        bvd     = 10           xjbvd   = 1          
+pbs     = 1            cjs     = 0.0005       mjs     = 0.5          pbsws   = 1          
+cjsws   = 5e-010       mjsws   = 0.33         pbswgs  = 1            cjswgs  = 3e-010     
+mjswgs  = 0.33         pbd     = 1            cjd     = 0.0005       mjd     = 0.5        
+pbswd   = 1            cjswd   = 5e-010       mjswd   = 0.33         pbswgd  = 1          
+cjswgd  = 5e-010       mjswgd  = 0.33         tpb     = 0.005        tcj     = 0.001      
+tpbsw   = 0.005        tcjsw   = 0.001        tpbswg  = 0.005        tcjswg  = 0.001      
+xtis    = 3            xtid    = 3          

+dmcg    = 0e-006       dmci    = 0e-006       dmdg    = 0e-006       dmcgt   = 0e-007     
+dwj     = 0.0e-008     xgw     = 0e-007       xgl     = 0e-008     

+rshg    = 0.4          gbmin   = 1e-010       rbpb    = 5            rbpd    = 15         
+rbps    = 15           rbdb    = 15           rbsb    = 15           ngcon   = 1          

* PTM 90nm PMOS
 
.model  pmos  pmos  level = 54

+version = 4.0          binunit = 1            paramchk= 1            mobmod  = 0          
+capmod  = 2            igcmod  = 1            igbmod  = 1            geomod  = 1          
+diomod  = 1            rdsmod  = 0            rbodymod= 1            rgatemod= 1          
+permod  = 1            acnqsmod= 0            trnqsmod= 0          

+tnom    = 27           toxe    = 2.15e-009    toxp    = 1.4e-009     toxm    = 2.15e-009   
+dtox    = 0.75e-9      epsrox  = 3.9          wint    = 5e-009       lint    = 7.5e-009   
+ll      = 0            wl      = 0            lln     = 1            wln     = 1          
+lw      = 0            ww      = 0            lwn     = 1            wwn     = 1          
+lwl     = 0            wwl     = 0            xpart   = 0            toxref  = 2.15e-009   
+xl      = -40e-9
+vth0    = -0.339       k1      = 0.4          k2      = -0.01        k3      = 0          
+k3b     = 0            w0      = 2.5e-006     dvt0    = 1            dvt1    = 2       
+dvt2    = -0.032       dvt0w   = 0            dvt1w   = 0            dvt2w   = 0          
+dsub    = 0.1          minv    = 0.05         voffl   = 0            dvtp0   = 1e-009     
+dvtp1   = 0.05         lpe0    = 0            lpeb    = 0            xj      = 2.8e-008   
+ngate   = 2e+020       ndep    = 1.43e+018    nsd     = 2e+020       phin    = 0          
+cdsc    = 0.000258     cdscb   = 0            cdscd   = 6.1e-008     cit     = 0          
+voff    = -0.126       nfactor = 1.7          eta0    = 0.0074       etab    = 0          
+vfb     = 0.55         u0      = 0.00711      ua      = 2.0e-009     ub      = 0.5e-018     
+uc      = -3e-011      vsat    = 70000        a0      = 1.0          ags     = 1e-020     
+a1      = 0            a2      = 1            b0      = 0            b1      = 0          
+keta    = -0.047       dwg     = 0            dwb     = 0            pclm    = 0.12       
+pdiblc1 = 0.001        pdiblc2 = 0.001        pdiblcb = 3.4e-008     drout   = 0.56       
+pvag    = 1e-020       delta   = 0.01         pscbe1  = 8.14e+008    pscbe2  = 9.58e-007  
+fprout  = 0.2          pdits   = 0.08         pditsd  = 0.23         pditsl  = 2.3e+006   
+rsh     = 5            rdsw    = 200          rsw     = 100          rdw     = 100        
+rdswmin = 0            rdwmin  = 0            rswmin  = 0            prwg    = 3.22e-008  
+prwb    = 6.8e-011     wr      = 1            alpha0  = 0.074        alpha1  = 0.005      
+beta0   = 30           agidl   = 0.0002       bgidl   = 2.1e+009     cgidl   = 0.0002     
+egidl   = 0.8          

+aigbacc = 0.012        bigbacc = 0.0028       cigbacc = 0.002     
+nigbacc = 1            aigbinv = 0.014        bigbinv = 0.004        cigbinv = 0.004      
+eigbinv = 1.1          nigbinv = 3            aigc    = 0.69         bigc    = 0.0012     
+cigc    = 0.0008       aigsd   = 0.0087       bigsd   = 0.0012       cigsd   = 0.0008     
+nigc    = 1            poxedge = 1            pigcd   = 1            ntox    = 1 
         
+xrcrg1  = 12           xrcrg2  = 5          
+cgso    = 1.8e-010     cgdo    = 1.8e-010     cgbo    = 2.56e-011    cgdl    = 2.653e-10
+cgsl    = 2.653e-10    ckappas = 0.03         ckappad = 0.03         acde    = 1
+moin    = 15           noff    = 0.9          voffcv  = 0.02

+kt1     = -0.11        kt1l    = 0            kt2     = 0.022        ute     = -1.5       
+ua1     = 4.31e-009    ub1     = 7.61e-018    uc1     = -5.6e-011    prt     = 0          
+at      = 33000      

+fnoimod = 1            tnoimod = 0          

+jss     = 0.0001       jsws    = 1e-011       jswgs   = 1e-010       njs     = 1          
+ijthsfwd= 0.01         ijthsrev= 0.001        bvs     = 10           xjbvs   = 1          
+jsd     = 0.0001       jswd    = 1e-011       jswgd   = 1e-010       njd     = 1          
+ijthdfwd= 0.01         ijthdrev= 0.001        bvd     = 10           xjbvd   = 1          
+pbs     = 1            cjs     = 0.0005       mjs     = 0.5          pbsws   = 1          
+cjsws   = 5e-010       mjsws   = 0.33         pbswgs  = 1            cjswgs  = 3e-010     
+mjswgs  = 0.33         pbd     = 1            cjd     = 0.0005       mjd     = 0.5        
+pbswd   = 1            cjswd   = 5e-010       mjswd   = 0.33         pbswgd  = 1          
+cjswgd  = 5e-010       mjswgd  = 0.33         tpb     = 0.005        tcj     = 0.001      
+tpbsw   = 0.005        tcjsw   = 0.001        tpbswg  = 0.005        tcjswg  = 0.001      
+xtis    = 3            xtid    = 3          

+dmcg    = 0e-006       dmci    = 0e-006       dmdg    = 0e-006       dmcgt   = 0e-007     
+dwj     = 0.0e-008     xgw     = 0e-007       xgl     = 0e-008     

+rshg    = 0.4          gbmin   = 1e-010       rbpb    = 5            rbpd    = 15         
+rbps    = 15           rbdb    = 15           rbsb    = 15           ngcon   = 1

.end