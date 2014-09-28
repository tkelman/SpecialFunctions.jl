function ZUNI2(ZR::Float64,ZI::Float64,FNU::Float64,KODE::Integer,N::Integer,YR::AbstractArray{Float64},YI::AbstractArray{Float64},NZ::Integer,NLAST::Integer,FNUL::Float64,TOL::Float64,ELIM::Float64,ALIM::Float64)
    AARG::Float64 = 0
    AIC::Float64 = 0
    AII::Float64 = 0
    AIR::Float64 = 0
    ANG::Float64 = 0
    APHI::Float64 = 0
    ARGI::Float64 = 0
    ARGR::Float64 = 0
    ASCLE::Float64 = 0
    ASUMI::Float64 = 0
    ASUMR::Float64 = 0
    BRY = Array(Float64,3)
    BSUMI::Float64 = 0
    BSUMR::Float64 = 0
    C1R::Float64 = 0
    C2I::Float64 = 0
    C2M::Float64 = 0
    C2R::Float64 = 0
    CAR::Float64 = 0
    CIDI::Float64 = 0
    CIPI = Array(Float64,4)
    CIPR = Array(Float64,4)
    CONER::Float64 = 0
    CRSC::Float64 = 0
    CSCL::Float64 = 0
    CSRR = Array(Float64,3)
    CSSR = Array(Float64,3)
    CYI = Array(Float64,2)
    CYR = Array(Float64,2)
    DAII::Float64 = 0
    DAIR::Float64 = 0
    FN::Float64 = 0
    HPI::Float64 = 0
    I::Int32 = 0
    IDUM::Int32 = 0
    IFLAG::Int32 = 0
    IN::Int32 = 0
    INU::Int32 = 0
    J::Int32 = 0
    K::Int32 = 0
    NAI::Int32 = 0
    ND::Int32 = 0
    NDAI::Int32 = 0
    NN::Int32 = 0
    NUF::Int32 = 0
    NW::Int32 = 0
    PHII::Float64 = 0
    PHIR::Float64 = 0
    RAST::Float64 = 0
    RAZ::Float64 = 0
    RS1::Float64 = 0
    RZI::Float64 = 0
    RZR::Float64 = 0
    S1I::Float64 = 0
    S1R::Float64 = 0
    S2I::Float64 = 0
    S2R::Float64 = 0
    SAR::Float64 = 0
    STI::Float64 = 0
    STR::Float64 = 0
    ZBI::Float64 = 0
    ZBR::Float64 = 0
    ZEROI::Float64 = 0
    ZEROR::Float64 = 0
    ZETA1I::Float64 = 0
    ZETA1R::Float64 = 0
    ZETA2I::Float64 = 0
    ZETA2R::Float64 = 0
    ZNI::Float64 = 0
    ZNR::Float64 = 0
    begin 
        ZEROR = 0.0
        ZEROI = 0.0
        CONER = 1.0
    end
    begin 
        CIPR[1] = 1.0
        CIPI[1] = 0.0
        CIPR[2] = 0.0
        CIPI[2] = 1.0
        CIPR[3] = -1.0
        CIPI[3] = 0.0
        CIPR[4] = 0.0
        CIPI[4] = -1.0
    end
    begin 
        HPI = 1.5707963267948966
        AIC = 1.2655121234846454
    end
    NZ = 0
    ND = N
    NLAST = 0
    CSCL = 1.0 / TOL
    CRSC = TOL
    CSSR[1] = CSCL
    CSSR[2] = CONER
    CSSR[3] = CRSC
    CSRR[1] = CRSC
    CSRR[2] = CONER
    CSRR[3] = CSCL
    BRY[1] = (1000.0D1MACH1) / TOL
    ZNR = ZI
    ZNI = -ZR
    ZBR = ZR
    ZBI = ZI
    CIDI = -CONER
    INU = INT(SNGL(FNU))
    ANG = HPI * (FNU - DBLE(FLOAT(INU)))
    C2R = DCOS(ANG)
    C2I = DSIN(ANG)
    CAR = C2R
    SAR = C2I
    IN = (INU + N) - 1
    IN = MOD(IN,4) + 1
    STR = C2R * CIPR[IN] - C2I * CIPI[IN]
    C2I = C2R * CIPI[IN] + C2I * CIPR[IN]
    C2R = STR
    if ZI > 0.0
        @goto line10
    end
    ZNR = -ZNR
    ZBI = -ZBI
    CIDI = -CIDI
    C2I = -C2I
    @label line10
    FN = DMAX1(FNU,1.0)
    (PHIR,PHII,ARGR,ARGI,ZETA1R,ZETA1I,ZETA2R,ZETA2I,ASUMR,ASUMI,BSUMR,BSUMI) = ZUNHJ(ZNR,ZNI,FN,1,TOL,PHIR,PHII,ARGR,ARGI,ZETA1R,ZETA1I,ZETA2R,ZETA2I,ASUMR,ASUMI,BSUMR,BSUMI)
    if KODE == 1
        @goto line20
    end
    STR = ZBR + ZETA2R
    STI = ZBI + ZETA2I
    RAST = FN / ZABS(COMPLEX(STR,STI))
    STR = STR * RAST * RAST
    STI = -STI * RAST * RAST
    S1R = -ZETA1R + STR
    S1I = -ZETA1I + STI
    @goto line30
    @label line20
    S1R = -ZETA1R + ZETA2R
    S1I = -ZETA1I + ZETA2I
    @label line30
    RS1 = S1R
    if DABS(RS1) > ELIM
        @goto line150
    end
    @label line40
    NN = MIN0(2,ND)
    for I = 1:NN
        FN = FNU + DBLE(FLOAT(ND - I))
        (PHIR,PHII,ARGR,ARGI,ZETA1R,ZETA1I,ZETA2R,ZETA2I,ASUMR,ASUMI,BSUMR,BSUMI) = ZUNHJ(ZNR,ZNI,FN,0,TOL,PHIR,PHII,ARGR,ARGI,ZETA1R,ZETA1I,ZETA2R,ZETA2I,ASUMR,ASUMI,BSUMR,BSUMI)
        if KODE == 1
            @goto line50
        end
        STR = ZBR + ZETA2R
        STI = ZBI + ZETA2I
        RAST = FN / ZABS(COMPLEX(STR,STI))
        STR = STR * RAST * RAST
        STI = -STI * RAST * RAST
        S1R = -ZETA1R + STR
        S1I = -ZETA1I + STI + DABS(ZI)
        @goto line60
        @label line50
        S1R = -ZETA1R + ZETA2R
        S1I = -ZETA1I + ZETA2I
        @label line60
        RS1 = S1R
        if DABS(RS1) > ELIM
            @goto line120
        end
        if I == 1
            IFLAG = 2
        end
        if DABS(RS1) < ALIM
            @goto line70
        end
        APHI = ZABS(COMPLEX(PHIR,PHII))
        AARG = ZABS(COMPLEX(ARGR,ARGI))
        RS1 = ((RS1 + DLOG(APHI)) - 0.25 * DLOG(AARG)) - AIC
        if DABS(RS1) > ELIM
            @goto line120
        end
        if I == 1
            IFLAG = 1
        end
        if RS1 < 0.0
            @goto line70
        end
        if I == 1
            IFLAG = 3
        end
        @label line70
        (AIR,AII,NAI,IDUM) = ZAIRY(ARGR,ARGI,0,2,AIR,AII,NAI,IDUM)
        (DAIR,DAII,NDAI,IDUM) = ZAIRY(ARGR,ARGI,1,2,DAIR,DAII,NDAI,IDUM)
        STR = DAIR * BSUMR - DAII * BSUMI
        STI = DAIR * BSUMI + DAII * BSUMR
        STR = STR + (AIR * ASUMR - AII * ASUMI)
        STI = STI + (AIR * ASUMI + AII * ASUMR)
        S2R = PHIR * STR - PHII * STI
        S2I = PHIR * STI + PHII * STR
        STR = DEXP(S1R) * CSSR[IFLAG]
        S1R = STR * DCOS(S1I)
        S1I = STR * DSIN(S1I)
        STR = S2R * S1R - S2I * S1I
        S2I = S2R * S1I + S2I * S1R
        S2R = STR
        if IFLAG != 1
            @goto line80
        end
        (NW,) = ZUCHK(S2R,S2I,NW,BRY[1],TOL)
        if NW != 0
            @goto line120
        end
        @label line80
        if ZI <= 0.0
            S2I = -S2I
        end
        STR = S2R * C2R - S2I * C2I
        S2I = S2R * C2I + S2I * C2R
        S2R = STR
        CYR[I] = S2R
        CYI[I] = S2I
        J = (ND - I) + 1
        YR[J] = S2R * CSRR[IFLAG]
        YI[J] = S2I * CSRR[IFLAG]
        STR = -C2I * CIDI
        C2I = C2R * CIDI
        C2R = STR
        @label line90
    end
    if ND <= 2
        @goto line110
    end
    RAZ = 1.0 / ZABS(COMPLEX(ZR,ZI))
    STR = ZR * RAZ
    STI = -ZI * RAZ
    RZR = (STR + STR) * RAZ
    RZI = (STI + STI) * RAZ
    BRY[2] = 1.0 / BRY[1]
    BRY[3] = D1MACH2
    S1R = CYR[1]
    S1I = CYI[1]
    S2R = CYR[2]
    S2I = CYI[2]
    C1R = CSRR[IFLAG]
    ASCLE = BRY[IFLAG]
    K = ND - 2
    FN = DBLE(FLOAT(K))
    for I = 3:ND
        C2R = S2R
        C2I = S2I
        S2R = S1R + (FNU + FN) * (RZR * C2R - RZI * C2I)
        S2I = S1I + (FNU + FN) * (RZR * C2I + RZI * C2R)
        S1R = C2R
        S1I = C2I
        C2R = S2R * C1R
        C2I = S2I * C1R
        YR[K] = C2R
        YI[K] = C2I
        K = K - 1
        FN = FN - 1.0
        if IFLAG >= 3
            @goto line100
        end
        STR = DABS(C2R)
        STI = DABS(C2I)
        C2M = DMAX1(STR,STI)
        if C2M <= ASCLE
            @goto line100
        end
        IFLAG = IFLAG + 1
        ASCLE = BRY[IFLAG]
        S1R = S1R * C1R
        S1I = S1I * C1R
        S2R = C2R
        S2I = C2I
        S1R = S1R * CSSR[IFLAG]
        S1I = S1I * CSSR[IFLAG]
        S2R = S2R * CSSR[IFLAG]
        S2I = S2I * CSSR[IFLAG]
        C1R = CSRR[IFLAG]
        @label line100
    end
    @label line110
    return (NZ,NLAST)
    @label line120
    if RS1 > 0.0
        @goto line140
    end
    YR[ND] = ZEROR
    YI[ND] = ZEROI
    NZ = NZ + 1
    ND = ND - 1
    if ND == 0
        @goto line110
    end
    (NUF,) = ZUOIK(ZR,ZI,FNU,KODE,1,ND,YR,YI,NUF,TOL,ELIM,ALIM)
    if NUF < 0
        @goto line140
    end
    ND = ND - NUF
    NZ = NZ + NUF
    if ND == 0
        @goto line110
    end
    FN = FNU + DBLE(FLOAT(ND - 1))
    if FN < FNUL
        @goto line130
    end
    IN = (INU + ND) - 1
    IN = MOD(IN,4) + 1
    C2R = CAR * CIPR[IN] - SAR * CIPI[IN]
    C2I = CAR * CIPI[IN] + SAR * CIPR[IN]
    if ZI <= 0.0
        C2I = -C2I
    end
    @goto line40
    @label line130
    NLAST = ND
    return (NZ,NLAST)
    @label line140
    NZ = -1
    return (NZ,NLAST)
    @label line150
    if RS1 > 0.0
        @goto line140
    end
    NZ = N
    for I = 1:N
        YR[I] = ZEROR
        YI[I] = ZEROI
        @label line160
    end
    return (NZ,NLAST)
end