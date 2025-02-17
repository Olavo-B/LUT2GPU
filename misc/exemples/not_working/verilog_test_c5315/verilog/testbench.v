/*
    * Testbench for c5315
    * Generated automatically
    * Description: Testing using grouped inputs from counters
    */

    module tb_top();
        // Testbench signals
        reg N1;
    reg N4;
    reg N11;
    reg N14;
    reg N17;
    reg N20;
    reg N23;
    reg N24;
    reg N25;
    reg N26;
    reg N27;
    reg N31;
    reg N34;
    reg N37;
    reg N40;
    reg N43;
    reg N46;
    reg N49;
    reg N52;
    reg N53;
    reg N54;
    reg N61;
    reg N64;
    reg N67;
    reg N70;
    reg N73;
    reg N76;
    reg N79;
    reg N80;
    reg N81;
    reg N82;
    reg N83;
    reg N86;
    reg N87;
    reg N88;
    reg N91;
    reg N94;
    reg N97;
    reg N100;
    reg N103;
    reg N106;
    reg N109;
    reg N112;
    reg N113;
    reg N114;
    reg N115;
    reg N116;
    reg N117;
    reg N118;
    reg N119;
    reg N120;
    reg N121;
    reg N122;
    reg N123;
    reg N126;
    reg N127;
    reg N128;
    reg N129;
    reg N130;
    reg N131;
    reg N132;
    reg N135;
    reg N136;
    reg N137;
    reg N140;
    reg N141;
    reg N145;
    reg N146;
    reg N149;
    reg N152;
    reg N155;
    reg N158;
    reg N161;
    reg N164;
    reg N167;
    reg N170;
    reg N173;
    reg N176;
    reg N179;
    reg N182;
    reg N185;
    reg N188;
    reg N191;
    reg N194;
    reg N197;
    reg N200;
    reg N203;
    reg N206;
    reg N209;
    reg N210;
    reg N217;
    reg N218;
    reg N225;
    reg N226;
    reg N233;
    reg N234;
    reg N241;
    reg N242;
    reg N245;
    reg N248;
    reg N251;
    reg N254;
    reg N257;
    reg N264;
    reg N265;
    reg N272;
    reg N273;
    reg N280;
    reg N281;
    reg N288;
    reg N289;
    reg N292;
    reg N293;
    reg N299;
    reg N302;
    reg N307;
    reg N308;
    reg N315;
    reg N316;
    reg N323;
    reg N324;
    reg N331;
    reg N332;
    reg N335;
    reg N338;
    reg N341;
    reg N348;
    reg N351;
    reg N358;
    reg N361;
    reg N366;
    reg N369;
    reg N372;
    reg N373;
    reg N374;
    reg N386;
    reg N389;
    reg N400;
    reg N411;
    reg N422;
    reg N435;
    reg N446;
    reg N457;
    reg N468;
    reg N479;
    reg N490;
    reg N503;
    reg N514;
    reg N523;
    reg N534;
    reg N545;
    reg N549;
    reg N552;
    reg N556;
    reg N559;
    reg N562;
    reg N566;
    reg N571;
    reg N574;
    reg N577;
    reg N580;
    reg N583;
    reg N588;
    reg N591;
    reg N592;
    reg N595;
    reg N596;
    reg N597;
    reg N598;
    reg N599;
    reg N603;
    reg N607;
    reg N610;
    reg N613;
    reg N616;
    reg N619;
    reg N625;
    reg N631;
    wire N709;
    wire N816;
    wire N1066;
    wire N1137;
    wire N1138;
    wire N1139;
    wire N1140;
    wire N1141;
    wire N1142;
    wire N1143;
    wire N1144;
    wire N1145;
    wire N1147;
    wire N1152;
    wire N1153;
    wire N1154;
    wire N1155;
    wire N1972;
    wire N2054;
    wire N2060;
    wire N2061;
    wire N2139;
    wire N2142;
    wire N2309;
    wire N2387;
    wire N2527;
    wire N2584;
    wire N2590;
    wire N2623;
    wire N3357;
    wire N3358;
    wire N3359;
    wire N3360;
    wire N3604;
    wire N3613;
    wire N4272;
    wire N4275;
    wire N4278;
    wire N4279;
    wire N4737;
    wire N4738;
    wire N4739;
    wire N4740;
    wire N5240;
    wire N5388;
    wire N6641;
    wire N6643;
    wire N6646;
    wire N6648;
    wire N6716;
    wire N6877;
    wire N6924;
    wire N6925;
    wire N6926;
    wire N6927;
    wire N7015;
    wire N7363;
    wire N7365;
    wire N7432;
    wire N7449;
    wire N7465;
    wire N7466;
    wire N7467;
    wire N7469;
    wire N7470;
    wire N7471;
    wire N7472;
    wire N7473;
    wire N7474;
    wire N7476;
    wire N7503;
    wire N7504;
    wire N7506;
    wire N7511;
    wire N7515;
    wire N7516;
    wire N7517;
    wire N7518;
    wire N7519;
    wire N7520;
    wire N7521;
    wire N7522;
    wire N7600;
    wire N7601;
    wire N7602;
    wire N7603;
    wire N7604;
    wire N7605;
    wire N7606;
    wire N7607;
    wire N7626;
    wire N7698;
    wire N7699;
    wire N7700;
    wire N7701;
    wire N7702;
    wire N7703;
    wire N7704;
    wire N7705;
    wire N7706;
    wire N7707;
    wire N7735;
    wire N7736;
    wire N7737;
    wire N7738;
    wire N7739;
    wire N7740;
    wire N7741;
    wire N7742;
    wire N7754;
    wire N7755;
    wire N7756;
    wire N7757;
    wire N7758;
    wire N7759;
    wire N7760;
    wire N7761;
    wire N8075;
    wire N8076;
    wire N8123;
    wire N8124;
    wire N8127;
    wire N8128;

        // Error and test tracking
        integer errors = 0;
        integer tests_run = 0;
        
        // Group counters
        integer counter_0;
    integer counter_1;
    integer counter_2;
    integer counter_3;
    integer counter_4;
    integer counter_5;


        // Device Under Test (DUT) instantiation
        c5315 dut(
            .N1(N1),
        .N4(N4),
        .N11(N11),
        .N14(N14),
        .N17(N17),
        .N20(N20),
        .N23(N23),
        .N24(N24),
        .N25(N25),
        .N26(N26),
        .N27(N27),
        .N31(N31),
        .N34(N34),
        .N37(N37),
        .N40(N40),
        .N43(N43),
        .N46(N46),
        .N49(N49),
        .N52(N52),
        .N53(N53),
        .N54(N54),
        .N61(N61),
        .N64(N64),
        .N67(N67),
        .N70(N70),
        .N73(N73),
        .N76(N76),
        .N79(N79),
        .N80(N80),
        .N81(N81),
        .N82(N82),
        .N83(N83),
        .N86(N86),
        .N87(N87),
        .N88(N88),
        .N91(N91),
        .N94(N94),
        .N97(N97),
        .N100(N100),
        .N103(N103),
        .N106(N106),
        .N109(N109),
        .N112(N112),
        .N113(N113),
        .N114(N114),
        .N115(N115),
        .N116(N116),
        .N117(N117),
        .N118(N118),
        .N119(N119),
        .N120(N120),
        .N121(N121),
        .N122(N122),
        .N123(N123),
        .N126(N126),
        .N127(N127),
        .N128(N128),
        .N129(N129),
        .N130(N130),
        .N131(N131),
        .N132(N132),
        .N135(N135),
        .N136(N136),
        .N137(N137),
        .N140(N140),
        .N141(N141),
        .N145(N145),
        .N146(N146),
        .N149(N149),
        .N152(N152),
        .N155(N155),
        .N158(N158),
        .N161(N161),
        .N164(N164),
        .N167(N167),
        .N170(N170),
        .N173(N173),
        .N176(N176),
        .N179(N179),
        .N182(N182),
        .N185(N185),
        .N188(N188),
        .N191(N191),
        .N194(N194),
        .N197(N197),
        .N200(N200),
        .N203(N203),
        .N206(N206),
        .N209(N209),
        .N210(N210),
        .N217(N217),
        .N218(N218),
        .N225(N225),
        .N226(N226),
        .N233(N233),
        .N234(N234),
        .N241(N241),
        .N242(N242),
        .N245(N245),
        .N248(N248),
        .N251(N251),
        .N254(N254),
        .N257(N257),
        .N264(N264),
        .N265(N265),
        .N272(N272),
        .N273(N273),
        .N280(N280),
        .N281(N281),
        .N288(N288),
        .N289(N289),
        .N292(N292),
        .N293(N293),
        .N299(N299),
        .N302(N302),
        .N307(N307),
        .N308(N308),
        .N315(N315),
        .N316(N316),
        .N323(N323),
        .N324(N324),
        .N331(N331),
        .N332(N332),
        .N335(N335),
        .N338(N338),
        .N341(N341),
        .N348(N348),
        .N351(N351),
        .N358(N358),
        .N361(N361),
        .N366(N366),
        .N369(N369),
        .N372(N372),
        .N373(N373),
        .N374(N374),
        .N386(N386),
        .N389(N389),
        .N400(N400),
        .N411(N411),
        .N422(N422),
        .N435(N435),
        .N446(N446),
        .N457(N457),
        .N468(N468),
        .N479(N479),
        .N490(N490),
        .N503(N503),
        .N514(N514),
        .N523(N523),
        .N534(N534),
        .N545(N545),
        .N549(N549),
        .N552(N552),
        .N556(N556),
        .N559(N559),
        .N562(N562),
        .N566(N566),
        .N571(N571),
        .N574(N574),
        .N577(N577),
        .N580(N580),
        .N583(N583),
        .N588(N588),
        .N591(N591),
        .N592(N592),
        .N595(N595),
        .N596(N596),
        .N597(N597),
        .N598(N598),
        .N599(N599),
        .N603(N603),
        .N607(N607),
        .N610(N610),
        .N613(N613),
        .N616(N616),
        .N619(N619),
        .N625(N625),
        .N631(N631),
        .N709(N709),
        .N816(N816),
        .N1066(N1066),
        .N1137(N1137),
        .N1138(N1138),
        .N1139(N1139),
        .N1140(N1140),
        .N1141(N1141),
        .N1142(N1142),
        .N1143(N1143),
        .N1144(N1144),
        .N1145(N1145),
        .N1147(N1147),
        .N1152(N1152),
        .N1153(N1153),
        .N1154(N1154),
        .N1155(N1155),
        .N1972(N1972),
        .N2054(N2054),
        .N2060(N2060),
        .N2061(N2061),
        .N2139(N2139),
        .N2142(N2142),
        .N2309(N2309),
        .N2387(N2387),
        .N2527(N2527),
        .N2584(N2584),
        .N2590(N2590),
        .N2623(N2623),
        .N3357(N3357),
        .N3358(N3358),
        .N3359(N3359),
        .N3360(N3360),
        .N3604(N3604),
        .N3613(N3613),
        .N4272(N4272),
        .N4275(N4275),
        .N4278(N4278),
        .N4279(N4279),
        .N4737(N4737),
        .N4738(N4738),
        .N4739(N4739),
        .N4740(N4740),
        .N5240(N5240),
        .N5388(N5388),
        .N6641(N6641),
        .N6643(N6643),
        .N6646(N6646),
        .N6648(N6648),
        .N6716(N6716),
        .N6877(N6877),
        .N6924(N6924),
        .N6925(N6925),
        .N6926(N6926),
        .N6927(N6927),
        .N7015(N7015),
        .N7363(N7363),
        .N7365(N7365),
        .N7432(N7432),
        .N7449(N7449),
        .N7465(N7465),
        .N7466(N7466),
        .N7467(N7467),
        .N7469(N7469),
        .N7470(N7470),
        .N7471(N7471),
        .N7472(N7472),
        .N7473(N7473),
        .N7474(N7474),
        .N7476(N7476),
        .N7503(N7503),
        .N7504(N7504),
        .N7506(N7506),
        .N7511(N7511),
        .N7515(N7515),
        .N7516(N7516),
        .N7517(N7517),
        .N7518(N7518),
        .N7519(N7519),
        .N7520(N7520),
        .N7521(N7521),
        .N7522(N7522),
        .N7600(N7600),
        .N7601(N7601),
        .N7602(N7602),
        .N7603(N7603),
        .N7604(N7604),
        .N7605(N7605),
        .N7606(N7606),
        .N7607(N7607),
        .N7626(N7626),
        .N7698(N7698),
        .N7699(N7699),
        .N7700(N7700),
        .N7701(N7701),
        .N7702(N7702),
        .N7703(N7703),
        .N7704(N7704),
        .N7705(N7705),
        .N7706(N7706),
        .N7707(N7707),
        .N7735(N7735),
        .N7736(N7736),
        .N7737(N7737),
        .N7738(N7738),
        .N7739(N7739),
        .N7740(N7740),
        .N7741(N7741),
        .N7742(N7742),
        .N7754(N7754),
        .N7755(N7755),
        .N7756(N7756),
        .N7757(N7757),
        .N7758(N7758),
        .N7759(N7759),
        .N7760(N7760),
        .N7761(N7761),
        .N8075(N8075),
        .N8076(N8076),
        .N8123(N8123),
        .N8124(N8124),
        .N8127(N8127),
        .N8128(N8128)
        );

        // Test stimulus and verification
        initial begin
            $display("Starting grouped input test for c5315");
            
            
                for (counter_0 = 0; counter_0 < 1073741824; counter_0 = counter_0 + 1) begin
            for (counter_1 = 0; counter_1 < 1073741824; counter_1 = counter_1 + 1) begin
            for (counter_2 = 0; counter_2 < 1073741824; counter_2 = counter_2 + 1) begin
            for (counter_3 = 0; counter_3 < 1073741824; counter_3 = counter_3 + 1) begin
            for (counter_4 = 0; counter_4 < 1073741824; counter_4 = counter_4 + 1) begin
            for (counter_5 = 0; counter_5 < 268435456; counter_5 = counter_5 + 1) begin
                    
                    // Assign inputs from counters
                    N1 = counter_0[0];
                N4 = counter_0[1];
                N11 = counter_0[2];
                N14 = counter_0[3];
                N17 = counter_0[4];
                N20 = counter_0[5];
                N23 = counter_0[6];
                N24 = counter_0[7];
                N25 = counter_0[8];
                N26 = counter_0[9];
                N27 = counter_0[10];
                N31 = counter_0[11];
                N34 = counter_0[12];
                N37 = counter_0[13];
                N40 = counter_0[14];
                N43 = counter_0[15];
                N46 = counter_0[16];
                N49 = counter_0[17];
                N52 = counter_0[18];
                N53 = counter_0[19];
                N54 = counter_0[20];
                N61 = counter_0[21];
                N64 = counter_0[22];
                N67 = counter_0[23];
                N70 = counter_0[24];
                N73 = counter_0[25];
                N76 = counter_0[26];
                N79 = counter_0[27];
                N80 = counter_0[28];
                N81 = counter_0[29];
                N82 = counter_1[0];
                N83 = counter_1[1];
                N86 = counter_1[2];
                N87 = counter_1[3];
                N88 = counter_1[4];
                N91 = counter_1[5];
                N94 = counter_1[6];
                N97 = counter_1[7];
                N100 = counter_1[8];
                N103 = counter_1[9];
                N106 = counter_1[10];
                N109 = counter_1[11];
                N112 = counter_1[12];
                N113 = counter_1[13];
                N114 = counter_1[14];
                N115 = counter_1[15];
                N116 = counter_1[16];
                N117 = counter_1[17];
                N118 = counter_1[18];
                N119 = counter_1[19];
                N120 = counter_1[20];
                N121 = counter_1[21];
                N122 = counter_1[22];
                N123 = counter_1[23];
                N126 = counter_1[24];
                N127 = counter_1[25];
                N128 = counter_1[26];
                N129 = counter_1[27];
                N130 = counter_1[28];
                N131 = counter_1[29];
                N132 = counter_2[0];
                N135 = counter_2[1];
                N136 = counter_2[2];
                N137 = counter_2[3];
                N140 = counter_2[4];
                N141 = counter_2[5];
                N145 = counter_2[6];
                N146 = counter_2[7];
                N149 = counter_2[8];
                N152 = counter_2[9];
                N155 = counter_2[10];
                N158 = counter_2[11];
                N161 = counter_2[12];
                N164 = counter_2[13];
                N167 = counter_2[14];
                N170 = counter_2[15];
                N173 = counter_2[16];
                N176 = counter_2[17];
                N179 = counter_2[18];
                N182 = counter_2[19];
                N185 = counter_2[20];
                N188 = counter_2[21];
                N191 = counter_2[22];
                N194 = counter_2[23];
                N197 = counter_2[24];
                N200 = counter_2[25];
                N203 = counter_2[26];
                N206 = counter_2[27];
                N209 = counter_2[28];
                N210 = counter_2[29];
                N217 = counter_3[0];
                N218 = counter_3[1];
                N225 = counter_3[2];
                N226 = counter_3[3];
                N233 = counter_3[4];
                N234 = counter_3[5];
                N241 = counter_3[6];
                N242 = counter_3[7];
                N245 = counter_3[8];
                N248 = counter_3[9];
                N251 = counter_3[10];
                N254 = counter_3[11];
                N257 = counter_3[12];
                N264 = counter_3[13];
                N265 = counter_3[14];
                N272 = counter_3[15];
                N273 = counter_3[16];
                N280 = counter_3[17];
                N281 = counter_3[18];
                N288 = counter_3[19];
                N289 = counter_3[20];
                N292 = counter_3[21];
                N293 = counter_3[22];
                N299 = counter_3[23];
                N302 = counter_3[24];
                N307 = counter_3[25];
                N308 = counter_3[26];
                N315 = counter_3[27];
                N316 = counter_3[28];
                N323 = counter_3[29];
                N324 = counter_4[0];
                N331 = counter_4[1];
                N332 = counter_4[2];
                N335 = counter_4[3];
                N338 = counter_4[4];
                N341 = counter_4[5];
                N348 = counter_4[6];
                N351 = counter_4[7];
                N358 = counter_4[8];
                N361 = counter_4[9];
                N366 = counter_4[10];
                N369 = counter_4[11];
                N372 = counter_4[12];
                N373 = counter_4[13];
                N374 = counter_4[14];
                N386 = counter_4[15];
                N389 = counter_4[16];
                N400 = counter_4[17];
                N411 = counter_4[18];
                N422 = counter_4[19];
                N435 = counter_4[20];
                N446 = counter_4[21];
                N457 = counter_4[22];
                N468 = counter_4[23];
                N479 = counter_4[24];
                N490 = counter_4[25];
                N503 = counter_4[26];
                N514 = counter_4[27];
                N523 = counter_4[28];
                N534 = counter_4[29];
                N545 = counter_5[0];
                N549 = counter_5[1];
                N552 = counter_5[2];
                N556 = counter_5[3];
                N559 = counter_5[4];
                N562 = counter_5[5];
                N566 = counter_5[6];
                N571 = counter_5[7];
                N574 = counter_5[8];
                N577 = counter_5[9];
                N580 = counter_5[10];
                N583 = counter_5[11];
                N588 = counter_5[12];
                N591 = counter_5[13];
                N592 = counter_5[14];
                N595 = counter_5[15];
                N596 = counter_5[16];
                N597 = counter_5[17];
                N598 = counter_5[18];
                N599 = counter_5[19];
                N603 = counter_5[20];
                N607 = counter_5[21];
                N610 = counter_5[22];
                N613 = counter_5[23];
                N616 = counter_5[24];
                N619 = counter_5[25];
                N625 = counter_5[26];
                N631 = counter_5[27];

                    
                    // Allow signals to propagate
                    #1;
                    
                    // Track test execution
                    tests_run = tests_run + 1;
                    
                    // Add verification logic here
                    // Example:
                    // if (output_doesnt_match_expected)
                    //     errors = errors + 1;
                    
                end
            end
            end
            end
            end
            
            end

            // Test summary
            $display("Test Summary:");
            $display("  Total Tests: %0d", tests_run);
            $display("  Errors Found: %0d", errors);

            if (errors == 0)
                $display("PASSED: All tests successful!");
            else
                $display("FAILED: %0d errors detected", errors);

            $finish;
        end

    endmodule
    