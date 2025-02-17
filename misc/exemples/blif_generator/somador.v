// Benchmark "/app/results/blif_generator/somador" written by ABC on Sat Feb  1 16:08:00 2025

module \/app/results/blif_generator/somador  ( 
    x00, x01, x02, x03, x04, x05, x06, x07, x08, x09, x10, x11, x12, x13,
    x14, x15,
    z0, z1, z2, z3, z4, z5, z6, z7, z8  );
  input  x00, x01, x02, x03, x04, x05, x06, x07, x08, x09, x10, x11, x12,
    x13, x14, x15;
  output z0, z1, z2, z3, z4, z5, z6, z7, z8;
  wire new_n28, new_n29, new_n30, new_n31, new_n32, new_n33, new_n34,
    new_n35, new_n36, new_n37, new_n38, new_n39, new_n40, new_n41, new_n42,
    new_n43, new_n44, new_n45, new_n46, new_n47, new_n48, new_n49, new_n50,
    new_n51, new_n52, new_n53, new_n54, new_n55, new_n56, new_n57, new_n58,
    new_n59, new_n60, new_n61, new_n62, new_n63, new_n64, new_n65, new_n66,
    new_n67, new_n68, new_n69, new_n70, new_n71, new_n72, new_n73, new_n74,
    new_n75, new_n76, new_n77, new_n78, new_n79, new_n80, new_n81, new_n82,
    new_n83, new_n84, new_n85, new_n86, new_n87, new_n88, new_n89, new_n90,
    new_n91, new_n92, new_n93, new_n94, new_n95, new_n96, new_n97, new_n98,
    new_n99, new_n100, new_n101, new_n102, new_n103, new_n104, new_n105,
    new_n106, new_n107, new_n108, new_n109, new_n110, new_n111, new_n112,
    new_n113, new_n114, new_n115, new_n116, new_n117, new_n118, new_n119,
    new_n120, new_n121, new_n122, new_n123, new_n124, new_n125, new_n126,
    new_n127, new_n128, new_n129, new_n130, new_n131, new_n132, new_n133,
    new_n134, new_n135, new_n136, new_n137, new_n138, new_n139, new_n140,
    new_n141, new_n142, new_n143, new_n144, new_n145, new_n146, new_n147,
    new_n148, new_n149, new_n150, new_n151, new_n152, new_n153, new_n154,
    new_n155, new_n156, new_n157, new_n158, new_n159, new_n160, new_n161,
    new_n162, new_n163, new_n164, new_n165, new_n166, new_n167, new_n168,
    new_n169, new_n170, new_n171, new_n172, new_n173, new_n174, new_n175,
    new_n176, new_n177, new_n178, new_n179, new_n180, new_n181, new_n182,
    new_n183, new_n184, new_n185, new_n186, new_n187, new_n188, new_n189,
    new_n190, new_n191, new_n192, new_n193, new_n194, new_n195, new_n196,
    new_n197, new_n198, new_n199, new_n200, new_n201, new_n202, new_n203,
    new_n204, new_n205, new_n206, new_n207, new_n208, new_n209, new_n210,
    new_n211, new_n212, new_n213, new_n214, new_n215, new_n216, new_n217,
    new_n218, new_n219, new_n220, new_n221, new_n222, new_n223, new_n224,
    new_n225, new_n226, new_n227, new_n228, new_n229, new_n230, new_n231,
    new_n232, new_n233, new_n234, new_n235, new_n236, new_n237, new_n238,
    new_n239, new_n240, new_n241, new_n242, new_n243, new_n244, new_n245,
    new_n246, new_n247, new_n248, new_n249, new_n250, new_n251, new_n252,
    new_n253, new_n254, new_n255, new_n256, new_n257, new_n258, new_n259,
    new_n260, new_n261, new_n262, new_n263, new_n264, new_n265, new_n266,
    new_n267, new_n268, new_n269, new_n270, new_n271, new_n272, new_n273,
    new_n274, new_n275, new_n276, new_n277, new_n278, new_n279, new_n280,
    new_n281, new_n282, new_n283, new_n284, new_n285, new_n286, new_n287,
    new_n288, new_n289, new_n290, new_n291, new_n292, new_n293, new_n294,
    new_n295, new_n296, new_n297, new_n298, new_n299, new_n300, new_n301,
    new_n302, new_n303, new_n304, new_n305, new_n306, new_n307, new_n308,
    new_n309, new_n310, new_n311, new_n312, new_n313, new_n314, new_n315,
    new_n316, new_n317, new_n318, new_n319, new_n320, new_n321, new_n322,
    new_n323, new_n324, new_n325, new_n326, new_n327, new_n328, new_n329,
    new_n330, new_n331, new_n332, new_n333, new_n334, new_n335, new_n336,
    new_n337, new_n338, new_n339, new_n340, new_n341, new_n342, new_n343,
    new_n344, new_n345, new_n346, new_n347, new_n348, new_n349, new_n350,
    new_n351, new_n352, new_n353, new_n354, new_n355, new_n356, new_n357,
    new_n358, new_n359, new_n360, new_n361, new_n362, new_n363, new_n364,
    new_n365, new_n366, new_n367, new_n368, new_n369, new_n370, new_n371,
    new_n372, new_n373, new_n374, new_n375, new_n376, new_n377, new_n378,
    new_n379, new_n380, new_n381, new_n382, new_n383, new_n384, new_n385,
    new_n386, new_n387, new_n388, new_n389, new_n390, new_n391, new_n392,
    new_n393, new_n394, new_n395, new_n396, new_n397, new_n398, new_n399,
    new_n400, new_n401, new_n402, new_n403, new_n404, new_n405, new_n406,
    new_n407, new_n408, new_n409, new_n410, new_n411, new_n412, new_n413,
    new_n414, new_n415, new_n416, new_n417, new_n418, new_n419, new_n420,
    new_n421, new_n422, new_n423, new_n424, new_n425, new_n426, new_n427,
    new_n428, new_n429, new_n430, new_n431, new_n432, new_n433, new_n434,
    new_n435, new_n436, new_n437, new_n438, new_n439, new_n440, new_n441,
    new_n442, new_n443, new_n444, new_n445, new_n446, new_n447, new_n448,
    new_n449, new_n450, new_n451, new_n452, new_n453, new_n454, new_n455,
    new_n456, new_n457, new_n458, new_n459, new_n460, new_n461, new_n462,
    new_n463, new_n464, new_n465, new_n466, new_n467, new_n468, new_n469,
    new_n470, new_n471, new_n472, new_n473, new_n474, new_n475, new_n476,
    new_n477, new_n478, new_n479, new_n480, new_n481, new_n482, new_n483,
    new_n484, new_n485, new_n486, new_n487, new_n488, new_n489, new_n490,
    new_n491, new_n492, new_n493, new_n494, new_n495, new_n496, new_n497,
    new_n498, new_n499, new_n500, new_n501, new_n502, new_n503, new_n504,
    new_n505, new_n506, new_n507, new_n508, new_n509, new_n510, new_n511,
    new_n512, new_n513, new_n514, new_n515, new_n516, new_n517, new_n518,
    new_n519, new_n520, new_n521, new_n522, new_n523, new_n524, new_n525,
    new_n526, new_n527, new_n528, new_n529, new_n530, new_n531, new_n532,
    new_n533, new_n534, new_n535, new_n536, new_n537, new_n538, new_n539,
    new_n540, new_n541, new_n542, new_n543, new_n544, new_n545, new_n546,
    new_n547, new_n548, new_n549, new_n550, new_n551, new_n552, new_n553,
    new_n554, new_n555, new_n556, new_n557, new_n558, new_n559, new_n560,
    new_n561, new_n562, new_n563, new_n564, new_n565, new_n566, new_n567,
    new_n568, new_n569, new_n570, new_n571, new_n572, new_n573, new_n574,
    new_n575, new_n576, new_n577, new_n578, new_n579, new_n580, new_n581,
    new_n582, new_n583, new_n584, new_n585, new_n586, new_n587, new_n588,
    new_n589, new_n590, new_n591, new_n592, new_n593, new_n594, new_n595,
    new_n596, new_n597, new_n598, new_n599, new_n600, new_n601, new_n602,
    new_n603, new_n604, new_n605, new_n606, new_n607, new_n608, new_n609,
    new_n610, new_n611, new_n612, new_n613, new_n614, new_n615, new_n616,
    new_n617, new_n618, new_n619, new_n620, new_n621, new_n622, new_n623,
    new_n624, new_n625, new_n626, new_n627, new_n628, new_n629, new_n630,
    new_n631, new_n632, new_n633, new_n634, new_n635, new_n636, new_n637,
    new_n638, new_n639, new_n640, new_n641, new_n642, new_n643, new_n644,
    new_n645, new_n646, new_n647, new_n648, new_n649, new_n650, new_n651,
    new_n652, new_n653, new_n654, new_n655, new_n656, new_n657, new_n658,
    new_n659, new_n660, new_n661, new_n662, new_n663, new_n664, new_n665,
    new_n666, new_n667, new_n668, new_n669, new_n670, new_n671, new_n672,
    new_n673, new_n674, new_n675, new_n676, new_n677, new_n678, new_n679,
    new_n680, new_n681, new_n682, new_n683, new_n684, new_n685, new_n686,
    new_n687, new_n688, new_n689, new_n690, new_n691, new_n692, new_n693,
    new_n694, new_n695, new_n696, new_n697, new_n698, new_n699, new_n700,
    new_n701, new_n702, new_n703, new_n704, new_n705, new_n706, new_n707,
    new_n708, new_n709, new_n710, new_n711, new_n712, new_n713, new_n714,
    new_n715, new_n716, new_n717, new_n718, new_n719, new_n720, new_n721,
    new_n722, new_n723, new_n724, new_n725, new_n726, new_n727, new_n728,
    new_n729, new_n730, new_n731, new_n732, new_n733, new_n734, new_n735,
    new_n736, new_n737, new_n738, new_n739, new_n740, new_n741, new_n742,
    new_n743, new_n744, new_n745, new_n746, new_n747, new_n748, new_n749,
    new_n750, new_n751, new_n752, new_n753, new_n754, new_n755, new_n756,
    new_n757, new_n758, new_n759, new_n760, new_n761, new_n762, new_n763,
    new_n764, new_n765, new_n766, new_n767, new_n768, new_n769, new_n770,
    new_n771, new_n772, new_n773, new_n774, new_n775, new_n776, new_n777,
    new_n778, new_n779, new_n780, new_n781, new_n782, new_n783, new_n784,
    new_n785, new_n786, new_n787, new_n788, new_n789, new_n790, new_n791,
    new_n792, new_n793, new_n794, new_n795, new_n796, new_n797, new_n798,
    new_n799, new_n800, new_n801, new_n802, new_n803, new_n804, new_n805,
    new_n806, new_n807, new_n808, new_n809, new_n810, new_n811, new_n812,
    new_n813, new_n814, new_n815, new_n816, new_n817, new_n818, new_n819,
    new_n820, new_n821, new_n822, new_n823, new_n824, new_n825, new_n826,
    new_n827, new_n828, new_n829, new_n830, new_n831, new_n832, new_n833,
    new_n834, new_n835, new_n836, new_n837, new_n838, new_n839, new_n840,
    new_n841, new_n842, new_n843, new_n844, new_n845, new_n846, new_n847,
    new_n848, new_n849, new_n850, new_n851, new_n852, new_n853, new_n854,
    new_n855, new_n856, new_n857, new_n858, new_n859, new_n860, new_n861,
    new_n862, new_n863, new_n864, new_n865, new_n866, new_n867, new_n868,
    new_n869, new_n870, new_n871, new_n872, new_n873, new_n874, new_n875,
    new_n876, new_n877, new_n878, new_n879, new_n880, new_n881, new_n882,
    new_n883, new_n884, new_n885, new_n886, new_n887, new_n888, new_n889,
    new_n890, new_n891, new_n892, new_n893, new_n894, new_n895, new_n896,
    new_n897, new_n898, new_n899, new_n900, new_n901, new_n902, new_n903,
    new_n904, new_n905, new_n906, new_n907, new_n908, new_n909, new_n910,
    new_n911, new_n912, new_n913, new_n914, new_n915, new_n916, new_n917,
    new_n918, new_n919, new_n920, new_n921, new_n922, new_n923, new_n924,
    new_n925, new_n926, new_n927, new_n928, new_n929, new_n930, new_n931,
    new_n932, new_n933, new_n934, new_n935, new_n936, new_n937, new_n938,
    new_n939, new_n940, new_n941, new_n942, new_n943, new_n944, new_n945,
    new_n946, new_n947, new_n948, new_n949, new_n950, new_n951, new_n952,
    new_n953, new_n954, new_n955, new_n956, new_n957, new_n958, new_n959,
    new_n960, new_n961, new_n962, new_n963, new_n964, new_n965, new_n966,
    new_n967, new_n968, new_n969, new_n970, new_n971, new_n972, new_n973,
    new_n974, new_n975, new_n976, new_n977, new_n978, new_n979, new_n980,
    new_n981, new_n982, new_n983, new_n984, new_n985, new_n986, new_n987,
    new_n988, new_n989, new_n990, new_n991, new_n992, new_n993, new_n994,
    new_n995, new_n996, new_n997, new_n998, new_n999, new_n1000, new_n1001,
    new_n1002, new_n1003, new_n1004, new_n1005, new_n1006, new_n1007,
    new_n1008, new_n1009, new_n1010, new_n1011, new_n1012, new_n1013,
    new_n1014, new_n1015, new_n1016, new_n1017, new_n1018, new_n1019,
    new_n1020, new_n1021, new_n1023, new_n1024, new_n1025, new_n1026,
    new_n1027, new_n1028, new_n1029, new_n1030, new_n1031, new_n1032,
    new_n1033, new_n1034, new_n1035, new_n1036, new_n1037, new_n1038,
    new_n1039, new_n1040, new_n1041, new_n1042, new_n1043, new_n1044,
    new_n1045, new_n1046, new_n1047, new_n1048, new_n1049, new_n1050,
    new_n1051, new_n1052, new_n1053, new_n1054, new_n1055, new_n1056,
    new_n1057, new_n1058, new_n1059, new_n1060, new_n1061, new_n1062,
    new_n1063, new_n1064, new_n1065, new_n1066, new_n1067, new_n1068,
    new_n1069, new_n1070, new_n1071, new_n1072, new_n1073, new_n1074,
    new_n1075, new_n1076, new_n1077, new_n1078, new_n1079, new_n1080,
    new_n1081, new_n1082, new_n1083, new_n1084, new_n1085, new_n1086,
    new_n1087, new_n1088, new_n1089, new_n1090, new_n1091, new_n1092,
    new_n1093, new_n1094, new_n1095, new_n1096, new_n1097, new_n1098,
    new_n1099, new_n1100, new_n1101, new_n1102, new_n1103, new_n1104,
    new_n1105, new_n1106, new_n1107, new_n1108, new_n1109, new_n1110,
    new_n1111, new_n1112, new_n1113, new_n1114, new_n1115, new_n1116,
    new_n1117, new_n1118, new_n1119, new_n1120, new_n1121, new_n1122,
    new_n1123, new_n1124, new_n1125, new_n1126, new_n1127, new_n1128,
    new_n1129, new_n1130, new_n1131, new_n1132, new_n1133, new_n1134,
    new_n1135, new_n1136, new_n1137, new_n1138, new_n1139, new_n1140,
    new_n1141, new_n1142, new_n1143, new_n1144, new_n1145, new_n1146,
    new_n1147, new_n1148, new_n1149, new_n1150, new_n1151, new_n1152,
    new_n1153, new_n1154, new_n1155, new_n1156, new_n1157, new_n1158,
    new_n1159, new_n1160, new_n1161, new_n1162, new_n1163, new_n1164,
    new_n1165, new_n1166, new_n1167, new_n1168, new_n1169, new_n1170,
    new_n1171, new_n1172, new_n1173, new_n1174, new_n1175, new_n1176,
    new_n1177, new_n1178, new_n1179, new_n1180, new_n1181, new_n1182,
    new_n1183, new_n1184, new_n1185, new_n1186, new_n1187, new_n1188,
    new_n1189, new_n1190, new_n1191, new_n1192, new_n1193, new_n1194,
    new_n1195, new_n1196, new_n1197, new_n1198, new_n1199, new_n1200,
    new_n1201, new_n1202, new_n1203, new_n1204, new_n1205, new_n1206,
    new_n1207, new_n1208, new_n1209, new_n1210, new_n1211, new_n1212,
    new_n1213, new_n1214, new_n1215, new_n1216, new_n1217, new_n1218,
    new_n1219, new_n1220, new_n1221, new_n1222, new_n1223, new_n1224,
    new_n1225, new_n1226, new_n1227, new_n1228, new_n1229, new_n1230,
    new_n1231, new_n1232, new_n1233, new_n1234, new_n1235, new_n1236,
    new_n1237, new_n1238, new_n1239, new_n1240, new_n1241, new_n1242,
    new_n1243, new_n1244, new_n1245, new_n1246, new_n1247, new_n1248,
    new_n1249, new_n1250, new_n1251, new_n1252, new_n1253, new_n1254,
    new_n1255, new_n1256, new_n1257, new_n1258, new_n1259, new_n1260,
    new_n1261, new_n1262, new_n1263, new_n1264, new_n1265, new_n1266,
    new_n1267, new_n1268, new_n1269, new_n1270, new_n1271, new_n1272,
    new_n1273, new_n1274, new_n1275, new_n1276, new_n1277, new_n1278,
    new_n1279, new_n1280, new_n1281, new_n1282, new_n1283, new_n1284,
    new_n1285, new_n1286, new_n1287, new_n1288, new_n1289, new_n1290,
    new_n1291, new_n1292, new_n1293, new_n1294, new_n1295, new_n1296,
    new_n1297, new_n1298, new_n1299, new_n1300, new_n1301, new_n1302,
    new_n1303, new_n1304, new_n1305, new_n1306, new_n1307, new_n1308,
    new_n1309, new_n1310, new_n1311, new_n1312, new_n1313, new_n1314,
    new_n1315, new_n1316, new_n1317, new_n1318, new_n1319, new_n1320,
    new_n1321, new_n1322, new_n1323, new_n1324, new_n1325, new_n1326,
    new_n1327, new_n1328, new_n1329, new_n1330, new_n1331, new_n1332,
    new_n1333, new_n1334, new_n1335, new_n1336, new_n1337, new_n1338,
    new_n1339, new_n1340, new_n1341, new_n1342, new_n1343, new_n1344,
    new_n1345, new_n1346, new_n1347, new_n1348, new_n1349, new_n1350,
    new_n1351, new_n1352, new_n1353, new_n1354, new_n1355, new_n1356,
    new_n1357, new_n1358, new_n1359, new_n1360, new_n1361, new_n1362,
    new_n1363, new_n1364, new_n1365, new_n1366, new_n1367, new_n1368,
    new_n1369, new_n1370, new_n1371, new_n1372, new_n1374, new_n1375,
    new_n1376, new_n1377, new_n1378, new_n1379, new_n1380, new_n1381,
    new_n1382, new_n1383, new_n1384, new_n1385, new_n1386, new_n1387,
    new_n1388, new_n1389, new_n1390, new_n1391, new_n1392, new_n1393,
    new_n1394, new_n1395, new_n1396, new_n1397, new_n1398, new_n1399,
    new_n1400, new_n1401, new_n1402, new_n1403, new_n1404, new_n1405,
    new_n1406, new_n1407, new_n1408, new_n1409, new_n1410, new_n1411,
    new_n1412, new_n1414, new_n1415, new_n1416, new_n1417, new_n1418,
    new_n1419, new_n1420, new_n1421, new_n1422, new_n1423, new_n1425,
    new_n1426, new_n1428, new_n1429, new_n1430, new_n1431;
  assign z0 = new_n669 | ~new_n835 | (x05 & ~new_n28);
  assign new_n28 = new_n603 & ((~new_n29 & new_n306 & x09) | (new_n458 & ~x09));
  assign new_n29 = x10 & (~new_n274 | new_n30 | (~new_n125 & x12));
  assign new_n30 = x04 & (~new_n102 | (~x12 & (~new_n84 | new_n31)));
  assign new_n31 = x06 & (new_n63 | (x03 & (~new_n43 | new_n32)));
  assign new_n32 = x02 & (new_n33 | (~new_n39 & ~new_n41 & x00));
  assign new_n33 = x08 & (new_n37 | (~new_n34 & ~x00));
  assign new_n34 = ~new_n35 & (x07 | (~new_n36 & x11));
  assign new_n35 = (~x14 | ~x15 | (~x11 ^ x13)) & x07 & (~x11 | ~x13 | (x14 & x15));
  assign new_n36 = ~x14 & x13;
  assign new_n37 = ~new_n35 & x01 & (x07 | (new_n38 & x11));
  assign new_n38 = x13 & x14;
  assign new_n39 = ~x01 & ((~x07 & (~x11 | ~x08)) | (new_n40 & x08 & x07));
  assign new_n40 = x15 & new_n38 & x11;
  assign new_n41 = x01 & ((new_n42 & x08) | (~x07 & ~x11 & ~x08));
  assign new_n42 = (x14 & ((x15 & x07 & (~x11 ^ ~x13)) | (x11 & x13 & (~x15 | ~x07)))) | (x13 & ~x14 & x07 & x11);
  assign new_n43 = ~new_n44 & (~new_n58 | (~new_n53 & ~new_n61 & x07));
  assign new_n44 = x00 & ((new_n51 & new_n52) | (~new_n45 & new_n50));
  assign new_n45 = ~new_n46 & (~new_n47 | (~new_n48 & new_n49));
  assign new_n46 = ~x07 & x11;
  assign new_n47 = ~x02 & ~x11;
  assign new_n48 = ~x15 & x14;
  assign new_n49 = (x13 | ~x15 | ~x07) & (~x14 | x07);
  assign new_n50 = ~x01 & ~x08;
  assign new_n51 = ~x02 & x01;
  assign new_n52 = ~x11 & x07;
  assign new_n53 = x11 & (~new_n54 | (~new_n57 & ~x01));
  assign new_n54 = x13 ? (~new_n51 | (~new_n55 & ~x00)) : new_n56;
  assign new_n55 = x14 & x15;
  assign new_n56 = (x02 | ~x01 | ~x00) & (~x14 | ~x15 | x01 | x00);
  assign new_n57 = (~x13 | ~x14 | (x15 ^ x00)) & (x02 | x00 | x14);
  assign new_n58 = x08 & (x07 | new_n59 | ~new_n60);
  assign new_n59 = new_n47 & (x01 | (~x00 & x14));
  assign new_n60 = (x01 | ((~x00 | x11) & (new_n36 | x00 | ~x11))) & (~x00 | ~x11 | x02 | ~x01);
  assign new_n61 = new_n62 & ((~x02 & (x14 | (~x13 & x15))) | (x14 & x13 & x15));
  assign new_n62 = ~x11 & ~x00 & ~x01;
  assign new_n63 = new_n71 & (~x07 | new_n64 | (~new_n80 & new_n83));
  assign new_n64 = ~x02 & (new_n65 | (~new_n70 & new_n68));
  assign new_n65 = ~x01 & ((~new_n66 & x00) | (~new_n67 & x08 & ~x00));
  assign new_n66 = (x03 & (~x08 | (x13 & x15 & x14))) | (~x08 & ~x14 & (x13 | ~x15));
  assign new_n67 = (~x14 | (x13 ^ x15)) & (x03 | x13 | ~x15);
  assign new_n68 = ~x00 & new_n69;
  assign new_n69 = x01 & x08;
  assign new_n70 = x15 & x13 & x14;
  assign new_n71 = x11 & ((~new_n72 & new_n74) | x07 | new_n77);
  assign new_n72 = new_n73 & (~x08 | (x03 & x14) | (~x13 & ~x14));
  assign new_n73 = ~x01 & (~x00 | (~x08 & (~x14 | x03)));
  assign new_n74 = ~x02 & (new_n76 | new_n75 | ~x01);
  assign new_n75 = ~x00 & x08;
  assign new_n76 = ~x03 & x00;
  assign new_n77 = new_n78 & (x08 | new_n79);
  assign new_n78 = ~x03 & x02;
  assign new_n79 = ~x01 & x00;
  assign new_n80 = (x00 | ~new_n82) & (new_n81 | x03);
  assign new_n81 = (~x01 & (x00 | (x15 & x13))) | (~x14 & ~x00 & x13);
  assign new_n82 = x13 & ~x01 & ~x14;
  assign new_n83 = x02 & x08;
  assign new_n84 = ~new_n99 & (x06 | (~new_n96 & (~x07 | new_n85)));
  assign new_n85 = (new_n94 | ~new_n95) & (~x14 | (~new_n92 & ~new_n86));
  assign new_n86 = x08 & (new_n87 | (new_n90 & new_n91 & x15));
  assign new_n87 = x11 & (new_n89 | (~new_n88 & x13));
  assign new_n88 = (~x03 | (x01 ? ~x02 : x00)) & (x02 | x01 | x15 | x00);
  assign new_n89 = x15 & ~x03 & ~x02 & ~x00 & ~x01;
  assign new_n90 = ~x02 & ~x00 & ~x01;
  assign new_n91 = ~x11 & x03;
  assign new_n92 = x15 & new_n79 & ~x08 & ~new_n93 & ~x02;
  assign new_n93 = x03 ^ ~x11;
  assign new_n94 = (~x02 & (x11 | (~x01 & ~x00))) | (x11 & (new_n38 | (~x01 & x00)));
  assign new_n95 = x03 & x08;
  assign new_n96 = new_n97 & (x13 ? ~x07 : x03);
  assign new_n97 = x11 & x08 & ~x02 & new_n98;
  assign new_n98 = ~x00 & ~x01;
  assign new_n99 = x11 & x08 & new_n101 & new_n100 & new_n36;
  assign new_n100 = x08 & new_n98 & x07;
  assign new_n101 = ~x02 & ~x03;
  assign new_n102 = (new_n103 | ~x00) & (~x08 | (~new_n124 & (new_n117 | x00)));
  assign new_n103 = (new_n116 | ~new_n114) & (x08 | (~new_n112 & ~new_n104));
  assign new_n104 = ~x02 & (new_n110 | (~new_n105 & ~x01 & x13));
  assign new_n105 = (~new_n109 | ~new_n108) & (new_n107 | new_n93 | new_n106);
  assign new_n106 = x14 & ((x06 & (~x07 | ~x15)) | (x07 & x15 & ~x06));
  assign new_n107 = x15 & x07 & x14;
  assign new_n108 = x06 & ~x11 & x07;
  assign new_n109 = x15 & x03 & x14;
  assign new_n110 = new_n111 & (x06 ? (~x07 | ~x03) : x03);
  assign new_n111 = ~x11 & x01;
  assign new_n112 = new_n113 & ((~x01 & (~x03 ^ ~x06)) | (~x07 & x03 & x06));
  assign new_n113 = ~x11 & x02;
  assign new_n114 = x08 & ~new_n115 & ~x11;
  assign new_n115 = ~x01 & ((x03 & x06) | (~x03 & ~x06) | (x07 & (~x02 | ~x06)));
  assign new_n116 = x01 & (~x02 | ~x03 | x06 | x07) & (~x06 | ~x07 | x02 | x03);
  assign new_n117 = ~new_n118 & (new_n123 | ~new_n122 | ~x03 | ~x13);
  assign new_n118 = x02 & ((~new_n119 & x06) | (new_n121 & x03 & ~x06));
  assign new_n119 = (~x01 | ~x11 | x07 | new_n120) & (x03 | ((new_n120 | ~x01 | ~x11) & (x07 | x11)));
  assign new_n120 = (x14 | ~x07 | ~x13) & (~x03 | x13);
  assign new_n121 = ~x07 & ~x11;
  assign new_n122 = ~x01 & ~x02;
  assign new_n123 = (x14 | (x11 & (~x07 | x06))) & (x11 | x06 | (x15 & x07));
  assign new_n124 = new_n111 & ((~x02 & ~x07 & (~x03 ^ ~x06)) | (x02 & x07 & ~x03 & x06));
  assign new_n125 = new_n218 & (~x07 | (~new_n179 & ~new_n126 & new_n194));
  assign new_n126 = x13 & (new_n165 | (x03 & (new_n152 | new_n127)));
  assign new_n127 = x00 & (new_n132 | new_n141 | new_n148 | new_n128);
  assign new_n128 = new_n83 & (new_n129 | (~new_n131 & x01));
  assign new_n129 = x06 & ~x04 & new_n130;
  assign new_n130 = ~x14 & x11;
  assign new_n131 = x04 ? ((x15 | ((x06 | x11) & (~x14 | ~x06 | ~x11))) & (~x15 | (x14 ? (~x06 ^ x11) : (~x06 | ~x11))) & (x14 | x06 | x11)) : ((x15 | ((~x06 | x11) & (~x14 | x06 | ~x11))) & (~x06 | ((x14 | x11) & (~x15 | ~x14 | ~x11))));
  assign new_n132 = new_n137 & (new_n135 | new_n133 | new_n140 | ~x14);
  assign new_n133 = ~new_n134 & (x04 ? (~x06 ^ ~x11) : (x06 & x11));
  assign new_n134 = ~x02 & (x01 ^ x15);
  assign new_n135 = ~new_n136 & x11 & ((~x15 & x02) | (x01 & (~x15 | x02)));
  assign new_n136 = ~x04 ^ ~x06;
  assign new_n137 = ~x08 & (new_n139 | new_n138 | x14);
  assign new_n138 = ~x04 & ~x01 & ~x02;
  assign new_n139 = x01 & x06 & x04 & ~x11 & x02;
  assign new_n140 = ~x15 & ~x06 & ~x04 & ~x01 & ~x02;
  assign new_n141 = ~x01 & ~new_n142 & (~x14 | new_n147 | new_n145);
  assign new_n142 = ~new_n143 & ~x14 & (~x11 | x06 | ~new_n144);
  assign new_n143 = x08 & ((~x02 & (x06 | (x11 & ~x04))) | (x04 & (~x06 ^ x11)));
  assign new_n144 = ~x02 & x04;
  assign new_n145 = ~new_n146 & ((x08 & (~x06 ^ x15)) | (~x02 & ~x06 & x15));
  assign new_n146 = x04 ^ ~x11;
  assign new_n147 = new_n47 & x06 & (x15 ? ~x04 : x08);
  assign new_n148 = new_n149 & (new_n151 | (~new_n150 & x08 & x14));
  assign new_n149 = ~x01 ^ ~x02;
  assign new_n150 = ((~x06 ^ x15) | (~x04 ^ x11)) & (~x04 | ~x11 | (x06 ^ x15));
  assign new_n151 = ~x14 & (x06 ? (x04 & ~x11) : (~x04 & x11));
  assign new_n152 = x08 & (new_n158 | (~x00 & (new_n162 | ~new_n153)));
  assign new_n153 = ~new_n155 & (x11 | (new_n154 & (~x06 | new_n157)));
  assign new_n154 = (~x04 | x06 | (new_n55 ? x01 : ~x02)) & (new_n55 | ~x06 | ~x01 | x02);
  assign new_n155 = x11 & x04 & ~new_n156 & x02;
  assign new_n156 = x06 ? (~x14 ^ x15) : (~x14 | ~x15);
  assign new_n157 = (~x14 | ((~x04 | (x01 & (~x15 | ~x02))) & (~x15 | x01 | x02))) & (x01 | ~x02 | x14);
  assign new_n158 = x01 & (new_n159 | (~new_n161 & x14));
  assign new_n159 = new_n160 & ((x02 & (~x06 ^ ~x11)) | (~x15 & x06 & x11) | (~x02 & (~x06 ^ x11)));
  assign new_n160 = ~x14 & x04;
  assign new_n161 = ((x06 ^ x15) | (x02 ? (~x04 | ~x11) : (x04 ^ ~x11))) & ((x06 ^ ~x15) | (x02 ? (x04 ^ ~x11) : (~x04 | ~x11))) & (~x02 | x04 | ~x06 | ~x15 | x11);
  assign new_n162 = ~x04 & (new_n164 | (~new_n163 & x14));
  assign new_n163 = (~x02 | (x15 ? (~x06 | ~x11) : (~x06 ^ x11))) & (x01 | ((x06 | ~x11) & (x15 | (~x11 & (x02 | x06)))));
  assign new_n164 = ~x14 & (x06 ? ((x02 & x11) | (x01 & (x02 | x11))) : ((~x02 & x11) | (~x01 & (~x02 | x11))));
  assign new_n165 = ~new_n166 & x11 & (~new_n177 | (~new_n171 & ~x03));
  assign new_n166 = new_n168 & (x03 | (~new_n167 & (~x00 | new_n170)));
  assign new_n167 = new_n75 & ((x04 & (~x01 ^ ~x02)) | (~x04 & x01 & x02) | (~x06 & ~x01 & ~x02));
  assign new_n168 = ~x14 & (~new_n169 | ~x08 | ~new_n90 | ~x15);
  assign new_n169 = x04 & x06;
  assign new_n170 = (x04 & ((~x06 & x01 & x02) | (~x08 & ~x01 & ~x02))) | (~x08 & x06) | (~x04 & ((x06 & (~x01 ^ x02)) | (~x08 & (~x01 ^ ~x02))));
  assign new_n171 = ~new_n172 & ((new_n176 & (~x06 ^ x15)) | (new_n175 & (x06 ^ x15)));
  assign new_n172 = x00 & (new_n140 | (new_n173 & new_n149 & new_n174));
  assign new_n173 = ~x06 ^ ~x15;
  assign new_n174 = (x15 | ~x08) & (x06 | ~x04);
  assign new_n175 = (~x01 | ((~x08 | (x00 ^ x02)) & (~x04 | (~x08 & (~x00 | ~x02))))) & (~x02 | ~x08 | (~x04 & (x00 | x01)));
  assign new_n176 = ((~x00 | ~x08) & (~x02 | (~x04 & ~x01))) | (~x00 & ~x08) | (~x02 & ~x01);
  assign new_n177 = x14 & (~new_n144 | new_n178);
  assign new_n178 = ((x00 ^ ~x08) | (~new_n173 ^ x01)) & (new_n173 | ~x00 | x01 | ~x08);
  assign new_n179 = ~x13 & (new_n192 | (~new_n180 & x06));
  assign new_n180 = ~new_n188 & (~x02 | (~new_n185 & (~x03 | new_n181)));
  assign new_n181 = (~new_n182 | ~x04) & (~x08 | (x04 ? new_n184 : new_n183));
  assign new_n182 = x00 & ((~x08 & (x01 | x11)) | (new_n55 & x01 & x11));
  assign new_n183 = ~x01 & (x00 | (new_n55 & x11));
  assign new_n184 = (x00 & x11 & x14 & x15) | (~x01 & (~x11 | ~x14 | ~x15));
  assign new_n185 = new_n186 & (x01 | (~new_n55 & ~x00));
  assign new_n186 = x08 & new_n187 & x04;
  assign new_n187 = ~x03 & x11;
  assign new_n188 = new_n51 & ((new_n76 & new_n191) | (~new_n189 & x08));
  assign new_n189 = (~x03 & ~x11) | (~x04 & (x11 ? ~new_n190 : x00));
  assign new_n190 = x15 & x14 & ~x00 & ~x03;
  assign new_n191 = ~x04 & x11;
  assign new_n192 = new_n193 & ((~x00 & ~x11 & x02) | (x01 & (~x11 | x02)));
  assign new_n193 = new_n95 & ~x06 & x04;
  assign new_n194 = ~new_n216 & (x01 | (new_n209 & (~x06 | new_n195)));
  assign new_n195 = ~new_n201 & (~x00 | (~new_n196 & (~new_n91 | new_n208)));
  assign new_n196 = x11 & (new_n199 | (~new_n197 & ~x02));
  assign new_n197 = x04 ? (x13 | (x08 & new_n55)) : new_n198;
  assign new_n198 = (x13 | (~x03 & (x15 | ~x14))) & (~x08 | x03 | x14);
  assign new_n199 = new_n200 & ((~new_n55 & x03 & x08) | (~x04 & (~x03 | x08)));
  assign new_n200 = ~x13 & x02;
  assign new_n201 = new_n75 & (new_n206 | (x11 & (~new_n203 | new_n202)));
  assign new_n202 = new_n78 & ((~x13 & x15 & x14) | (~x04 & ~x14));
  assign new_n203 = ~new_n204 & (x02 | new_n205);
  assign new_n204 = ~x13 & x03 & ((x04 & ~x14) | (x15 & ~x04 & x14));
  assign new_n205 = (~x03 | x14 | x04) & (x13 | ~x15 | ~x14 | ~x04);
  assign new_n206 = x03 & ~new_n207 & ~x13;
  assign new_n207 = (x11 | ~x04) & (x02 | x15 | ~x14 | x04);
  assign new_n208 = (x13 | (x08 ? x02 : ~x04)) & (x04 | x08 | ~new_n48 | x02);
  assign new_n209 = ~new_n214 & (new_n93 | (~new_n215 & ~new_n210));
  assign new_n210 = new_n211 & (x06 ? ~x13 : x14);
  assign new_n211 = x15 & ~new_n213 & new_n212;
  assign new_n212 = ~x02 & ~x04;
  assign new_n213 = x00 ^ ~x08;
  assign new_n214 = x00 & new_n193 & ~x11 & ~x13;
  assign new_n215 = x08 & x00 & new_n169 & new_n200;
  assign new_n216 = new_n75 & new_n129 & new_n217;
  assign new_n217 = new_n101 & x01;
  assign new_n218 = new_n257 & (~x06 | (~new_n247 & (x07 | new_n219)));
  assign new_n219 = ~new_n238 & (~x03 | (~new_n231 & (~x00 | new_n220)));
  assign new_n220 = ~new_n226 & new_n228 & (~x13 | (~new_n221 & new_n223));
  assign new_n221 = ~new_n222 & x04;
  assign new_n222 = (~x11 | ((~x14 | ((~x01 | x08) & (~x02 | (~x01 & x08)))) & (x02 | ~x01 | ~x08 | x14))) & (x02 | ~x01 | ~x08 | x11 | ~x14);
  assign new_n223 = (new_n225 | x01) & (~new_n224 | ~new_n212 | ~x08 | ~x01);
  assign new_n224 = x11 & x14;
  assign new_n225 = (~x08 | ((x11 | ~x04 | ~x14) & (~x02 | ~x11 | (~x04 ^ x14)))) & (x02 | ((x11 | ~x04 | ~x14) & (x08 | x04 | x14)));
  assign new_n226 = x08 & ~new_n38 & new_n227;
  assign new_n227 = (~x01 | x02) & ((x04 & ~x11) | (x13 & ~x04 & x11));
  assign new_n228 = (~new_n230 | ~new_n138) & (x04 | ~new_n38 | ~new_n229);
  assign new_n229 = ~x08 & x11 & (x02 | ~x01);
  assign new_n230 = x14 & ~x08 & ~x11;
  assign new_n231 = x08 & ((~new_n236 & x14) | new_n234 | new_n232);
  assign new_n232 = ~new_n233 & (x02 ? ~x00 : x01);
  assign new_n233 = (x14 | ((~x04 | x11) & (~x13 | x04 | ~x11))) & (~x04 | ((x13 | x11) & (~x14 | ~x13 | ~x11)));
  assign new_n234 = x11 & x01 & new_n36 & new_n235;
  assign new_n235 = x02 & x04;
  assign new_n236 = (new_n146 | new_n237 | ~x13) & (~new_n212 | ~new_n62);
  assign new_n237 = x01 ? ~x02 : x00;
  assign new_n238 = x11 & (new_n245 | (~x03 & (new_n243 | new_n239)));
  assign new_n239 = x14 & ((~new_n241 & new_n242) | (~new_n240 & x00));
  assign new_n240 = (~x13 & (x01 | x02)) | (x04 & ((~x01 & ~x02) | (x08 & x01 & x02))) | (~x04 & (x08 ^ (x01 & x02)));
  assign new_n241 = x13 & ((x00 & (~x01 | ~x02)) | (~x01 & ~x02) | (~x04 & x01 & x02));
  assign new_n242 = x08 & (x13 | (~x01 & ~x02 & ~x00));
  assign new_n243 = x08 & ~new_n244 & new_n36;
  assign new_n244 = (~x04 & ~x00 & ~x01) | (~x02 & (~x00 | ~x01));
  assign new_n245 = new_n246 & ((~x00 & x01 & ~x14 & x08) | (~x01 & (x00 ? (~x14 ^ ~x08) : (x14 & x08))));
  assign new_n246 = x13 & ~x02 & x04;
  assign new_n247 = ~x14 & (new_n255 | (~new_n248 & ~x01));
  assign new_n248 = ~new_n251 & (x02 | (~new_n249 & (~x11 | new_n254)));
  assign new_n249 = x13 & new_n250 & x08 & ~x00 & ~x11;
  assign new_n250 = ~x04 & x03;
  assign new_n251 = x13 & x11 & x02 & ~new_n253 & new_n252;
  assign new_n252 = ~x08 & x00;
  assign new_n253 = x03 ^ ~x04;
  assign new_n254 = (x03 | ((~x00 | ~x13 | x08 | x04) & (~x08 | ~x04 | x00 | x13))) & (~x03 | ~x00 | ~x13 | x08 | ~x04);
  assign new_n255 = new_n256 & (x02 ? (~x03 ^ x04) : (x03 ^ x04));
  assign new_n256 = x13 & x11 & new_n252 & x01;
  assign new_n257 = ~new_n271 & (x06 | (~new_n269 & (~x11 | new_n258)));
  assign new_n258 = (new_n259 | ~x00) & (~x08 | (~new_n267 & (new_n262 | x00)));
  assign new_n259 = (new_n261 | x13) & (new_n260 | x07 | ~x13);
  assign new_n260 = x04 ? ((~x08 & ~x01 & ~x02 & ~x03) | (x08 & x01 & x02 & x03)) : (((~x02 ^ ~x03) & (x08 ^ ~x01)) | (~x08 & x01 & ~x02 & ~x03));
  assign new_n261 = (x01 & ((x02 & ((x03 & x04) | (~x08 & ~x03 & ~x04))) | (~x08 & ~x02 & (x03 ^ x04)))) | (~x08 & ~x01 & (x02 ? (x03 ^ x04) : (~x03 ^ x04)));
  assign new_n262 = ~new_n265 & (~new_n263 | new_n266) & (new_n264 | x13);
  assign new_n263 = ~x03 ^ ~x04;
  assign new_n264 = (~x01 | x02 | (x03 ^ x04)) & (~x02 | ((x07 | ~x03 | ~x04) & (x01 | x03 | x04)));
  assign new_n265 = x13 & x01 & x04 & ~x02 & ~x07;
  assign new_n266 = (x07 | ~x13 | ~x02) & (x13 | (x01 ^ x02));
  assign new_n267 = new_n268 & (x04 ? (x02 & x03) : (x02 ^ x03));
  assign new_n268 = x13 & ~x07 & x01;
  assign new_n269 = x03 & ~new_n270 & new_n122;
  assign new_n270 = (~x04 | ~x00 | x08 | x13) & (x07 | x04 | ~x13 | (x00 ^ ~x08));
  assign new_n271 = new_n272 & x04 & x03 & ~new_n273 & ~x13;
  assign new_n272 = ~x07 & x08 & (x02 ? x00 : ~x01);
  assign new_n273 = x00 & (~x11 | ~x01);
  assign new_n274 = (new_n275 | ~x00) & (~x08 | (~new_n295 & (new_n302 | x00)));
  assign new_n275 = ~new_n293 & (x03 | new_n289) & (x04 | new_n276);
  assign new_n276 = ~new_n285 & (~x03 | new_n277) & (new_n283 | ~new_n288);
  assign new_n277 = (~new_n278 | new_n279) & (~new_n282 | (new_n281 & ~new_n280));
  assign new_n278 = ~x12 & x11;
  assign new_n279 = (x06 | ((~x02 | ~x08) & (~x01 | (~x02 & ~x08)))) & (~x02 | ~x08 | ~x07 | x01);
  assign new_n280 = x02 & ((~x01 & (x07 | ~x08)) | (x08 & (x07 ? ~x12 : x01)));
  assign new_n281 = x06 & (x07 | x01 | ~x08) & (x02 | ~x01 | x08);
  assign new_n282 = ~x11 & (x06 | ((~x02 | ~x01) & (x08 | x02 | x01)));
  assign new_n283 = (x03 | x11 | (x01 ^ ~x02)) & (~new_n284 | ~x11 | x02);
  assign new_n284 = x08 & ~x01 & ~x12;
  assign new_n285 = x02 & new_n69 & ~new_n287 & new_n286;
  assign new_n286 = ~x03 & ~x06;
  assign new_n287 = x11 & x12;
  assign new_n288 = x06 & x07;
  assign new_n289 = ~new_n290 & (~new_n292 | (x01 & x02) | (~x08 & ~x01 & ~x02));
  assign new_n290 = ~new_n291 & new_n288 & (new_n278 | new_n122);
  assign new_n291 = x01 ? x02 : (~x02 & (x11 | ~x08));
  assign new_n292 = ~x06 & (~x12 | ~x11);
  assign new_n293 = new_n122 & x03 & ~new_n294 & ~x12;
  assign new_n294 = (x06 | ~x11) & (~x07 | ((~x06 | ~x08 | x11) & (x08 | ~x11)));
  assign new_n295 = ~x04 & (new_n301 | (~new_n296 & x03));
  assign new_n296 = (~x06 & (x00 | new_n300)) | (~new_n297 & ~new_n299 & x06);
  assign new_n297 = ~x00 & ((new_n298 & ~x12 & x07) | (new_n113 & (~x12 | ~x07)));
  assign new_n298 = ~x01 & x11;
  assign new_n299 = x01 & ((~x12 & x02 & x07 & x11) | (~x02 & ~x07 & ~x11));
  assign new_n300 = (x12 | ~x11 | (x01 ^ x02)) & (x11 | (~x01 ^ x02));
  assign new_n301 = ~x00 & new_n278 & new_n288 & (new_n78 | new_n51);
  assign new_n302 = ~new_n303 & ((~new_n292 & ~new_n108) | x03 | new_n305);
  assign new_n303 = new_n111 & new_n304 & ~x12 & new_n288;
  assign new_n304 = ~x02 & x03;
  assign new_n305 = x01 ^ ~x02;
  assign new_n306 = ~new_n426 & (x10 | (~new_n394 & ~new_n307 & new_n453));
  assign new_n307 = x03 & ((~new_n355 & x08) | (~new_n308 & x00));
  assign new_n308 = ~new_n309 & (~x02 | (new_n339 & (~x06 | new_n314)));
  assign new_n309 = ~new_n310 & (x01 ^ x08);
  assign new_n310 = (~x02 | (~new_n311 & (x04 | x06))) & (~x06 | x02 | ~x07 | ~x04);
  assign new_n311 = new_n313 & new_n312 & (x04 ? (x06 ^ x15) : (x06 & x15));
  assign new_n312 = x14 & x12 & x13;
  assign new_n313 = x07 & x11;
  assign new_n314 = ~new_n337 & ~new_n315 & (~x12 | (~new_n322 & new_n327));
  assign new_n315 = x04 & ((~new_n320 & new_n321 & x01) | (~new_n316 & ~x01));
  assign new_n316 = ~new_n317 & (x08 | (~new_n278 & (~new_n319 | new_n318)));
  assign new_n317 = x07 & ~x12 & x08;
  assign new_n318 = x07 & ((x12 & (~x13 | ~x15)) | (~x14 & (x13 | ~x15)));
  assign new_n319 = ~x11 & (x07 | (x13 & ~x14) | (~x12 & x14));
  assign new_n320 = (~x11 & ~x08) | (new_n38 & x15 & x11 & x08);
  assign new_n321 = ~x12 & x07;
  assign new_n322 = ~new_n326 & x08 & (~new_n323 | (~new_n324 & new_n325));
  assign new_n323 = x13 & (~new_n191 | ((x01 | x14) & (new_n107 | ~x01 | ~x14)));
  assign new_n324 = x07 & ((x11 & x01 & ~x14) | (x14 & ((~x15 & (x11 | ~x01)) | (x11 & ~x01) | (x15 & ~x11 & x01))));
  assign new_n325 = x04 & ((x01 & (~x11 | ~x14)) | x07 | (x11 & x14 & ~x01));
  assign new_n326 = (~x11 | ((x04 | x01) & (x07 | ~x04 | ~x01))) & ~x13 & (~x04 | ~x01 | ~x07 | x11);
  assign new_n327 = (~new_n331 | new_n328) & (new_n336 | ~new_n335 | ~new_n334);
  assign new_n328 = ~x04 & (~x14 | new_n329) & (x08 | new_n330);
  assign new_n329 = (x08 & (~x11 | (x07 & x15))) | (~x13 & (x11 | (x07 & x15)));
  assign new_n330 = (x14 | ~x13 | x07) & (x11 | ~x15 | x13 | ~x07);
  assign new_n331 = ~x01 & (~x04 | new_n332 | (~x08 & new_n333));
  assign new_n332 = x07 & (~x13 | (~x11 & ~x15 & x14));
  assign new_n333 = x14 & ~x07 & x13;
  assign new_n334 = x11 & x13;
  assign new_n335 = ~x08 & x07;
  assign new_n336 = (~x01 | x14) & (~x04 | ~x15 | ~x14);
  assign new_n337 = ~new_n338 & ~x04;
  assign new_n338 = (x11 & (x08 ? x12 : x07)) | (~x01 & ~x08) | (x01 & ~x07 & x08);
  assign new_n339 = ~new_n348 & (x06 | (~new_n350 & (~x04 | new_n340)));
  assign new_n340 = new_n344 & (~x07 | (new_n341 & (new_n347 | ~new_n38)));
  assign new_n341 = (~new_n343 | ~x08 | ~x01) & (x12 | ((~x08 | ~x01) & (~new_n342 | x08 | x01)));
  assign new_n342 = x15 & ~x11 & x14;
  assign new_n343 = x11 & ~x13 & x12;
  assign new_n344 = (new_n345 | x08) & (~new_n346 | ~x12 | (x01 & ~x08));
  assign new_n345 = (~x12 | x13) & (x11 | (~x01 & (x07 | ~x13)));
  assign new_n346 = x13 & ~x07 & x11;
  assign new_n347 = (x11 | ((~x01 | ~x15 | ~x12 | ~x08) & (x01 | x15 | x08))) & (~x12 | ((x01 | x08) & (~x11 | x15 | ~x08)));
  assign new_n348 = x07 & (new_n349 | (~x04 & new_n343 & new_n69));
  assign new_n349 = new_n36 & new_n50 & (x04 ? ~x11 : x12);
  assign new_n350 = new_n352 & ((~new_n354 & new_n353) | (new_n50 & new_n351));
  assign new_n351 = ~x07 & x13;
  assign new_n352 = ~x04 & x12;
  assign new_n353 = x07 & x14;
  assign new_n354 = (~x13 | ((x01 | x08 | x15) & (~x08 | ~x15 | ~x11 | ~x01))) & (x08 | ~x15 | x11 | x01);
  assign new_n355 = ~new_n393 & (~x02 | (~new_n381 & (x00 | new_n356)));
  assign new_n356 = new_n368 & (~x04 | (~new_n362 & ~new_n357 & new_n379));
  assign new_n357 = x13 & (new_n360 | (x07 & (new_n361 | new_n358)));
  assign new_n358 = ~x01 & ((new_n287 & ~x14) | (new_n359 & x15 & x14));
  assign new_n359 = ~x12 & x06;
  assign new_n360 = x12 & new_n46 & (~x14 | ~x06);
  assign new_n361 = x11 & ((~x15 & ((x06 & ~x12) | (x14 & ~x06 & x12))) | (x06 & ((~x14 & ~x12) | (x15 & x14 & x12))));
  assign new_n362 = ~x11 & (new_n366 | (~new_n367 & ~x07) | (~new_n363 & x07));
  assign new_n363 = ~new_n82 & (x06 ? new_n364 : (~x14 | new_n365));
  assign new_n364 = (x13 & (~x14 | x15)) | (~x12 & (x01 | (~x14 & ~x15)));
  assign new_n365 = (x01 | (~x13 & (x12 | ~x15))) & (~x13 | ~x12 | ~x15);
  assign new_n366 = x01 & ((x07 & ~x12) | (x06 & new_n36 & x12));
  assign new_n367 = (~x13 | ~x12 | ~x06 | ~x14) & (x01 | (~x13 & (x12 | ~x06 | ~x14)));
  assign new_n368 = ~new_n378 & (x04 | (~new_n369 & (~new_n375 | new_n371)));
  assign new_n369 = new_n370 & new_n321;
  assign new_n370 = x06 & x11;
  assign new_n371 = new_n374 & (x06 ? new_n372 : (~x14 | new_n373));
  assign new_n372 = (x13 & (~x14 | x15)) | (~x11 & (x01 | (~x14 & ~x15)));
  assign new_n373 = (x01 | (~x13 & (x11 | ~x15))) & (~x13 | ~x11 | ~x15);
  assign new_n374 = x07 & (x01 | x14 | ~x13);
  assign new_n375 = x12 & ((~x01 & new_n376) | x07 | new_n377);
  assign new_n376 = ~x06 & x13;
  assign new_n377 = x06 & ((~x01 & (x13 | (~x11 & x14))) | (x13 & x11 & x14));
  assign new_n378 = x07 & new_n343 & ~x06 & x01;
  assign new_n379 = (new_n380 | x13) & (~new_n278 | (x06 ^ ~x07));
  assign new_n380 = (x01 | ~x12 | x06) & (x12 | ~x06 | ~x07 | ~x11);
  assign new_n381 = x01 & ((~new_n390 & x06) | new_n392 | new_n382);
  assign new_n382 = x12 & (~new_n387 | (~new_n383 & x13));
  assign new_n383 = (new_n385 | ~x11) & (~new_n386 | (x14 & (new_n384 | x11)));
  assign new_n384 = x07 & x15;
  assign new_n385 = (x04 & (~x06 | (~x07 & ~x14))) | (~x06 & ~x07) | (x14 & ((~x04 & x06) | (x15 & x07)));
  assign new_n386 = x07 & ~x06 & x04;
  assign new_n387 = (~x04 | ((new_n388 | (x06 ^ ~x11)) & (~new_n389 | (x06 ^ x11)))) & (new_n388 | ~x06 | ~x11 | x04);
  assign new_n388 = (x07 | x13) & (~x14 | ~x15 | ~x07 | ~x13);
  assign new_n389 = ~x13 & x07;
  assign new_n390 = (x07 | ((x04 | x12) & (x11 | (x04 & x12)))) & (~new_n391 | ~x04 | x12);
  assign new_n391 = x13 & x11 & new_n55 & x07;
  assign new_n392 = ~x06 & ((~x07 & (~x11 | ~x04)) | (~x04 & (~x12 | ~x11)));
  assign new_n393 = x04 & new_n51 & new_n288;
  assign new_n394 = x02 & ((~new_n421 & x04) | (~new_n395 & ~x03));
  assign new_n395 = ~new_n415 & (~new_n406 | (new_n420 & (~x11 | new_n396)));
  assign new_n396 = new_n397 & (~x13 | (~new_n402 & (~x04 | new_n405)));
  assign new_n397 = ~new_n398 & (~new_n317 | (~x00 & (~x04 | ~new_n48)));
  assign new_n398 = ~new_n399 & ((~new_n49 & new_n401) | (new_n48 & new_n400));
  assign new_n399 = x04 ^ ~x12;
  assign new_n400 = x00 & ~x08 & x07;
  assign new_n401 = ~x00 ^ ~x08;
  assign new_n402 = x12 & ((x00 & new_n404) | (~new_n403 & x08));
  assign new_n403 = (x14 | (x00 ? ~x07 : x04)) & (~x07 | (x15 ? (~x14 | x00) : ~x00));
  assign new_n404 = x14 & ((x04 & ~x07) | (x15 & ~x04 & x07));
  assign new_n405 = (x08 | ~x00 | ((x07 | x14) & (~x15 | ~x07 | ~x14))) & (x14 | x00 | ~x08 | x07);
  assign new_n406 = x06 & (~x01 | new_n407 | (~new_n411 & x08));
  assign new_n407 = x00 & (x04 ? new_n408 : (~x08 | x07));
  assign new_n408 = (x11 & x12) ? (new_n409 | new_n410) : x07;
  assign new_n409 = ~x13 & x08;
  assign new_n410 = x13 & ((x14 & x08 & (~x15 | ~x07)) | (x07 & (~x14 | (x15 & ~x08))));
  assign new_n411 = new_n412 & (new_n414 | ~new_n313 | ~x12);
  assign new_n412 = (x00 & x07) | (new_n413 & (x04 | x07));
  assign new_n413 = x11 & x12 & (x14 | ~x13);
  assign new_n414 = (~x15 | ~x14 | ~x04 | ~x13) & (x00 | (x13 & (x15 | ~x14)));
  assign new_n415 = x11 & ~x01 & ~new_n416 & ~new_n213;
  assign new_n416 = (x06 | new_n417) & (x14 | ~x07 | ~new_n419);
  assign new_n417 = (new_n418 | ~x04) & (~new_n55 | ~x07 | ~x12 | x04);
  assign new_n418 = (~x15 | ~x14 | x12 | ~x07) & (~x13 | (x07 & (x15 | ~x14)));
  assign new_n419 = x04 & x13;
  assign new_n420 = ~x01 & (x04 | x07 | ~x00 | ~x08);
  assign new_n421 = (new_n422 | ~x06) & (~new_n100 | ~new_n70 | ~new_n287 | x06);
  assign new_n422 = (new_n423 | x07) & (new_n425 | x01 | ~new_n287 | ~x07);
  assign new_n423 = (new_n424 | ~x11 | ~x08) & (~x01 | ~x00 | x08);
  assign new_n424 = (x01 | ((x12 | ~x00) & (~x13 | (x14 ? (~x12 | x00) : ~x00)))) & (x13 | ~x12 | x00 | ~x01);
  assign new_n425 = (x13 | ~x08 | x00) & (~x14 | ((x15 | ((~x08 | x00) & (~x13 | x08 | ~x00))) & (~x15 | ~x13 | ~x08 | ~x00)));
  assign new_n426 = x02 & (new_n450 | (~new_n443 & ~new_n427 & x11));
  assign new_n427 = x12 & (new_n439 | ~new_n263) & (new_n428 | x01);
  assign new_n428 = (new_n429 | ~x13) & (~new_n436 | ~new_n437 | ~new_n48 | x13);
  assign new_n429 = ~new_n433 & (~x00 | (~new_n430 & (x14 | new_n435)));
  assign new_n430 = new_n431 & ~x08 & ~new_n432 & ~x06;
  assign new_n431 = ~x03 & ~x04;
  assign new_n432 = x07 & (x15 | ~x14);
  assign new_n433 = new_n434 & ~x04 & ~x03 & ~new_n107 & ~x00;
  assign new_n434 = ~x06 & x08;
  assign new_n435 = (~x07 | ((x06 | ~x03 | ~x04) & (x08 | x03 | x04))) & (~x06 | x08 | (x03 ^ x04));
  assign new_n436 = ~x03 & new_n288;
  assign new_n437 = ~x00 & new_n438;
  assign new_n438 = ~x04 & x08;
  assign new_n439 = (new_n440 | ~x00 | x08) & (x13 | ~new_n442 | x00 | ~x08);
  assign new_n440 = (x01 | x06 | (~new_n441 & x13)) & (~x07 | x13 | ~x06);
  assign new_n441 = x15 & new_n353 & x13;
  assign new_n442 = ~x01 & ~x06;
  assign new_n443 = ~x12 & (~new_n288 | new_n444) & (new_n449 | ~new_n448);
  assign new_n444 = (~new_n447 | ~new_n445) & (x04 | ~x00 | ~new_n446);
  assign new_n445 = x15 & x14 & ~x00 & ~x01;
  assign new_n446 = ~x08 & x03;
  assign new_n447 = x13 & x08 & ~x03 & x04;
  assign new_n448 = ~x06 & x03;
  assign new_n449 = (~x04 | ((x01 | ~x00) & (x07 | ~x08 | x00))) & (x01 | ((x08 | ~x00) & (x04 | ~x08 | x00)));
  assign new_n450 = new_n451 & new_n288 & ~x04 & new_n70;
  assign new_n451 = x12 & new_n75 & ~x11 & new_n452;
  assign new_n452 = ~x01 & x03;
  assign new_n453 = ~new_n454 & ((~x00 & (~x01 | ~x08)) | ~new_n286 | (~x01 & ~x08));
  assign new_n454 = ~new_n455 & ((~x03 & x07 & x06) | (x04 & (x06 ? ~x07 : x03)));
  assign new_n455 = (x02 | ((~x00 | ~x08) & (~x01 | (~x00 & ~x08)))) & (~x00 | ~x08 | new_n456 | x01);
  assign new_n456 = ~new_n457 & x11;
  assign new_n457 = ~x13 & x12;
  assign new_n458 = ~new_n565 & (~x08 | (new_n521 & (~x04 | new_n459)));
  assign new_n459 = ~new_n520 & (~x03 | new_n460) & (new_n492 | ~x01);
  assign new_n460 = (new_n461 | ~x00) & (~x01 | (~new_n487 & (new_n474 | x00)));
  assign new_n461 = ~new_n473 & (new_n470 | new_n462 | ~x01);
  assign new_n462 = x02 & (x06 ? (new_n467 | new_n465) : new_n463);
  assign new_n463 = x11 & ((~x07 & ~x12) | (new_n464 & x13 & x12));
  assign new_n464 = (~x07 & ~x10) | (x14 & ((~x15 & ~x10) | (x07 & x15 & x10)));
  assign new_n465 = x12 & x07 & ~new_n466 & ~x10;
  assign new_n466 = x13 & (~x14 | (~x11 & x15) | (x11 & ~x15));
  assign new_n467 = ~new_n469 & x10 & (~new_n468 | (~x11 & x15) | (x11 & ~x15));
  assign new_n468 = x14 & x13 & x07 & x12;
  assign new_n469 = (x11 | x07) & (~x11 | ~x07) & (~x12 | ~x13 | ~x14);
  assign new_n470 = ~x02 & ~new_n471 & (x06 | new_n472);
  assign new_n471 = x10 & new_n287 & (x13 ? new_n106 : ~x06);
  assign new_n472 = x10 & x11;
  assign new_n473 = ~x01 & (~x06 | (~x07 & x02));
  assign new_n474 = (new_n485 & ((new_n480 & ~x02) | (new_n475 & ~x10))) | (~x10 & ~x02) | (new_n475 & new_n480 & x10 & x02);
  assign new_n475 = ~new_n479 & (~x12 | (new_n477 & (x06 | new_n476)));
  assign new_n476 = (~x11 | ~x10 | x13) & (x10 | ~x13 | ~x07 | ~new_n55);
  assign new_n477 = (~x06 | new_n478) & (~new_n130 | ~x07 | ~x13);
  assign new_n478 = (x07 | ~x13 | (x11 ^ ~x14)) & (~x10 | ((x07 | x13) & (x11 | x14 | ~x13)));
  assign new_n479 = (~x12 & ((x10 & ~x11) | (x06 & ~x10 & x11))) | (~x06 & x10 & ~x11);
  assign new_n480 = (~new_n484 | ~x11 | x12) & (~x12 | (~new_n482 & (~new_n481 | x11)));
  assign new_n481 = new_n389 & x06;
  assign new_n482 = x13 & ((~new_n483 & x06) | (~new_n432 & x11 & ~x06));
  assign new_n483 = (x02 | ~x11 | x14) & (x15 | ~x07 | x11 | ~x14);
  assign new_n484 = ~x07 & x06;
  assign new_n485 = (new_n486 | x13) & (x11 | (new_n106 ? x12 : ~x13));
  assign new_n486 = (~x12 | x06) & (x11 | ~x07 | ~x15 | x12 | ~x06);
  assign new_n487 = x02 & (new_n488 | (new_n359 & new_n472 & x07));
  assign new_n488 = x12 & (new_n489 | (~new_n491 & new_n481));
  assign new_n489 = x13 & ((~new_n490 & x11) | (new_n464 & new_n288 & ~x11));
  assign new_n490 = (x07 | x06 | x10) & (~x14 | ((~x07 | ~x15 | (~x06 ^ x10)) & (x15 | (x06 ^ x10)) & (x07 | ~x06 | ~x10)));
  assign new_n491 = ~x11 & x10;
  assign new_n492 = ~new_n517 & ((new_n493 & x10) | (~new_n512 & ~new_n519 & ~x10));
  assign new_n493 = (new_n506 | ~x11) & (~x06 | (new_n501 & (new_n494 | ~x11)));
  assign new_n494 = (new_n500 | ~new_n78) & (new_n495 | x00);
  assign new_n495 = ~new_n499 & ((~new_n496 & new_n497) | x02 | new_n498);
  assign new_n496 = ~x03 & ~x12 & (x15 ? ~x13 : x14);
  assign new_n497 = x07 & (~x12 | (x13 & (x15 | ~x14)));
  assign new_n498 = ~x07 & ((x03 & (~x12 | ~x14)) | (~x13 & (x12 | ~x14)));
  assign new_n499 = x02 & x13 & x12 & ~x03 & ~x14;
  assign new_n500 = (x12 | x07) & (~new_n312 | ~x15 | ~x07);
  assign new_n501 = ~new_n505 & (~x00 | (~new_n504 & (~new_n287 | new_n502)));
  assign new_n502 = (~new_n70 | ~x07 | x02) & (x03 | ~x02 | (~new_n503 & x07));
  assign new_n503 = x13 & ~x15 & x14;
  assign new_n504 = (~new_n413 | ~x13) & ((~x03 & x07 & x02) | (~x07 & ~x02));
  assign new_n505 = x02 & ~x11 & ~x00 & ~x03;
  assign new_n506 = ~new_n510 & (x03 | (~new_n509 & (x06 | new_n507)));
  assign new_n507 = (new_n508 | ~x12 | ~x02) & (new_n418 | x00 | x02);
  assign new_n508 = (~x14 & x13 & x07) | (~x00 & (~x13 | (x15 & x07)));
  assign new_n509 = x07 & new_n36 & ~x00 & ~x02;
  assign new_n510 = x07 & new_n511 & ~x06 & ~x00 & ~x02;
  assign new_n511 = x15 & x14 & x12 & x13;
  assign new_n512 = ~x00 & x02 & x11 & (new_n515 | new_n513);
  assign new_n513 = new_n514 & x13 & ~x15 & x07;
  assign new_n514 = new_n106 & x12;
  assign new_n515 = ~x03 & ((~x12 & ~new_n516) | (~new_n106 & x13));
  assign new_n516 = (~x07 | ~x15 | (x06 ? x13 : ~x14)) & (~x14 | ~x06 | (x07 & x15));
  assign new_n517 = new_n287 & x02 & ~x03 & ~new_n518 & ~x00;
  assign new_n518 = (~x07 & x06) | (x13 & (~new_n441 | x06));
  assign new_n519 = x00 & (x02 ? new_n286 : new_n484);
  assign new_n520 = x00 & new_n484 & ~x01 & ~x02;
  assign new_n521 = ~new_n564 & (~x01 | (~new_n549 & ~new_n558 & ~new_n522));
  assign new_n522 = new_n544 & (~x12 | new_n540 | (~x04 & ~new_n523));
  assign new_n523 = new_n534 & (~x13 | (~new_n530 & (~x06 | new_n524)));
  assign new_n524 = ~new_n526 & (~x10 | (new_n525 & (~x14 | new_n529)));
  assign new_n525 = (x02 | ((x00 | x14 | x03) & (~x14 | ~x03 | ~new_n384 | ~x00))) & (x14 | ~x03 | ~x02 | x00);
  assign new_n526 = x02 & (new_n527 | (new_n528 & (x00 | new_n48)));
  assign new_n527 = ~x14 & ~x07 & ~x00 & ~x03;
  assign new_n528 = x03 & x07 & (~x14 | ~x10);
  assign new_n529 = (~x02 | ~x07 | (~x03 & (~x15 | ~x00))) & (~x03 | x00 | (x15 & x07));
  assign new_n530 = x02 & (new_n533 | (~new_n531 & ~x06));
  assign new_n531 = (x00 & (~x10 | (~x03 & ~new_n532))) | (~new_n532 & (new_n432 | (~x10 & x03)));
  assign new_n532 = x15 & x14 & x03 & x07;
  assign new_n533 = x07 & ~x14 & ~x00 & ~x03;
  assign new_n534 = ~new_n537 & (x00 | (~new_n539 & (x03 | new_n535)));
  assign new_n535 = (new_n536 | (~x10 ^ x02)) & (x10 | ~x02 | ~new_n48 | ~new_n288);
  assign new_n536 = (~x06 | ~x07 | x13 | ~x15) & (~x14 | ((~x06 | x07) & (~x15 | x06 | ~x07)));
  assign new_n537 = new_n538 & ~new_n484 & ~x13;
  assign new_n538 = x02 & x03 & (x06 | (x00 & x10));
  assign new_n539 = x03 & x02 & ~x06 & ~x13;
  assign new_n540 = x06 & (new_n543 | (~new_n541 & ~x03 & x10));
  assign new_n541 = (new_n542 | ~x07) & (x00 | ~new_n38 | ~x02 | x07);
  assign new_n542 = (x13 | ~x00 | x02) & (~new_n48 | ((~x00 | x02) & (~x13 | x00 | ~x02)));
  assign new_n543 = new_n333 & x03 & x02 & ~x00 & ~x10;
  assign new_n544 = x11 & ((~new_n545 & x10) | x12 | new_n547);
  assign new_n545 = (new_n546 | ~x00) & (~new_n288 | x00 | (~x02 ^ x03));
  assign new_n546 = (x03 | ~x06 | ~x07 | x02) & (x04 | ~x02 | ~x03 | x06);
  assign new_n547 = x03 & ~new_n548 & x02;
  assign new_n548 = (x04 | ~x07 | ~x06) & (x00 | x06);
  assign new_n549 = new_n250 & ~new_n550 & ~x00;
  assign new_n550 = ~new_n557 & (~x12 | (~new_n554 & ~new_n551));
  assign new_n551 = new_n552 & x02 & x15 & (~x06 ^ ~x10);
  assign new_n552 = new_n553 & x14;
  assign new_n553 = x15 & x13 & x06 & x07;
  assign new_n554 = new_n556 & (new_n555 | (~new_n516 & ~x11));
  assign new_n555 = x13 & ~new_n106 & ~new_n107;
  assign new_n556 = ~x02 ^ ~x10;
  assign new_n557 = x02 & x10 & ~x11 & x06;
  assign new_n558 = x00 & (~new_n559 | (~new_n562 & ~x04));
  assign new_n559 = (x03 | new_n560) & (x10 | ~x07 | ~new_n561);
  assign new_n560 = (x04 | ~x02 | x06) & (x02 | ~x06 | ~new_n52 | ~x10);
  assign new_n561 = ~x02 & x06;
  assign new_n562 = (x07 | ~x06 | (x02 & ~x03)) & (~x03 | (x02 ? new_n563 : x06));
  assign new_n563 = x06 ? x11 : x10;
  assign new_n564 = new_n286 & ~x02 & x00;
  assign new_n565 = new_n602 & (new_n595 | (~x08 & (~new_n582 | new_n566)));
  assign new_n566 = x13 & (new_n579 | (x12 & (new_n576 | new_n567)));
  assign new_n567 = x02 & (new_n568 | (x14 & (new_n575 | new_n572)));
  assign new_n568 = x11 & (~new_n569 | (~new_n571 & x03));
  assign new_n569 = (x14 | ~new_n431 | ~x07) & (new_n570 | x07);
  assign new_n570 = (~x10 | x06 | ~x04) & (x03 | x04 | (x14 & x06));
  assign new_n571 = (x14 | ~x06 | ~x04) & (x07 | ~x10 | x06 | x04);
  assign new_n572 = x07 & ((~new_n574 & x11) | (~new_n573 & x03));
  assign new_n573 = (~x04 | ~x06 | ((x15 | ~x11) & (x10 | (x15 & ~x11)))) & (~x11 | ((~x15 | x04 | x06) & (~x10 | ((x04 | x06) & (~x15 | (x04 & x06))))));
  assign new_n574 = (~x10 | ((x03 | ~x06 | ~x15) & (~x04 | x06 | x15))) & (x03 | (x04 ? (x06 | ~x15) : (x06 ^ x15)));
  assign new_n575 = x06 & new_n46 & (x04 ? (x10 | ~x03) : x03);
  assign new_n576 = new_n577 & (x15 ? x03 : ~x02);
  assign new_n577 = x07 & new_n578 & x04;
  assign new_n578 = x10 & new_n224 & x06;
  assign new_n579 = new_n556 & (new_n580 | (~new_n288 & new_n514 & new_n581));
  assign new_n580 = ~new_n106 & ((x11 & ~x03 & x04) | (x03 & (x04 ? ~x11 : x12)));
  assign new_n581 = x03 & x04;
  assign new_n582 = ~new_n583 & (~new_n590 | x06) & (new_n516 | ~new_n593);
  assign new_n583 = x02 & (new_n588 | (~new_n584 & new_n457));
  assign new_n584 = (~new_n585 | (x06 & ~x07)) & (~new_n472 | ~new_n587 | ~x07);
  assign new_n585 = new_n253 ? new_n586 : x11;
  assign new_n586 = ~x10 & x03;
  assign new_n587 = x06 & x03 & x04;
  assign new_n588 = x03 & ((~new_n589 & x06) | (~x04 & new_n278 & ~x06));
  assign new_n589 = (~x07 | x11 | ~x10 | ~x04) & (x12 | ~x11 | (~x04 & ~x07));
  assign new_n590 = x12 & new_n591 & new_n592;
  assign new_n591 = new_n304 & x04;
  assign new_n592 = ~x13 & x10;
  assign new_n593 = ~new_n594 & ~new_n93 & ~new_n399;
  assign new_n594 = x02 ^ ~x10;
  assign new_n595 = x10 & (new_n601 | (~new_n596 & x06));
  assign new_n596 = (new_n597 | ~x02) & (new_n600 | ~new_n312 | ~x11 | x02);
  assign new_n597 = (~x03 | ~x04 | x07 | x11) & (~new_n598 | x03 | x04 | ~x07 | ~x11);
  assign new_n598 = new_n599 & ~x15 & x13;
  assign new_n599 = x12 & x14;
  assign new_n600 = x04 ? (x03 | x07) : (~x07 | (~x15 ^ x03));
  assign new_n601 = x13 & new_n287 & new_n591 & ~new_n432 & ~x06;
  assign new_n602 = x00 & x01;
  assign new_n603 = ~new_n604 & (~x01 | (~new_n616 & ~new_n653 & ~new_n664));
  assign new_n604 = (new_n101 | new_n581) & (new_n615 | (x08 & ~new_n605));
  assign new_n605 = (~new_n79 | ~new_n614) & (new_n606 | ~new_n613);
  assign new_n606 = (new_n607 | ~x13) & (~new_n612 | (x00 ^ x15));
  assign new_n607 = (new_n608 | ~x06) & (new_n611 | x01 | ~x09 | x06);
  assign new_n608 = (new_n609 | ~x07) & (new_n610 | x01 | ~x09 | x07);
  assign new_n609 = x00 ? ((~x01 | x14 | x09) & (~x14 | ~x09 | x15 | x01)) : ((x14 | ~x09 | x15 | x01) & (~x15 | ~x14 | (x01 ^ ~x09)));
  assign new_n610 = ~x00 ^ ~x14;
  assign new_n611 = (x07 | x00) & (~x14 | ((x15 | x00) & (~x07 | ~x15 | ~x00)));
  assign new_n612 = x14 & new_n288 & x09 & ~x01 & ~x13;
  assign new_n613 = new_n287 & x10;
  assign new_n614 = x06 & ~x09 & x07;
  assign new_n615 = x09 & new_n613 & new_n252 & ~x01 & new_n552;
  assign new_n616 = x12 & (new_n617 | (~new_n626 & ~new_n645 & x13));
  assign new_n617 = new_n592 & (new_n618 | (~x02 & new_n587 & new_n400));
  assign new_n618 = ~new_n619 & x11 & (~x02 | new_n625 | new_n624);
  assign new_n619 = ~x02 & ~new_n622 & (x03 | (~new_n623 & ~new_n620));
  assign new_n620 = new_n621 & x08 & ~x00 & ~x15;
  assign new_n621 = x06 & x14 & x07 & ~x04 & ~x15;
  assign new_n622 = new_n250 & ((x07 & (x08 ? x06 : x00)) | (~x06 & (~x00 ^ ~x08)));
  assign new_n623 = x04 & ((~x06 & (~x00 ^ ~x08)) | (x07 & x00 & ~x08));
  assign new_n624 = new_n252 & ((~x06 & (~x04 ^ x03)) | (~x07 & x04 & x03) | (x07 & ~x04 & ~x03));
  assign new_n625 = new_n431 & x08 & (x06 ? x07 : ~x00);
  assign new_n626 = x07 & (x14 ? new_n627 : (~x11 | new_n640));
  assign new_n627 = (~new_n628 & ~new_n633 & x03) | (~x03 & (~x11 | new_n637));
  assign new_n628 = new_n632 & (new_n630 | (~new_n213 & new_n629));
  assign new_n629 = x15 & ~x06 & new_n191;
  assign new_n630 = x04 & new_n631 & ~x11 & ~x15;
  assign new_n631 = x00 & ~x08 & x06;
  assign new_n632 = ~x02 & x10;
  assign new_n633 = new_n136 & (new_n635 | new_n634);
  assign new_n634 = x15 & new_n75 & ~x02 & new_n491;
  assign new_n635 = new_n636 & x00 & ~x15 & ~x08 & ~x10;
  assign new_n636 = x02 & x11;
  assign new_n637 = (new_n638 | ~new_n252) & (new_n639 | ~new_n437);
  assign new_n638 = (~x02 | ((~x15 | ~x10 | x06 | x04) & (x15 | x10 | ~x06 | ~x04))) & (x06 | x02 | ~x10 | (x04 ^ x15));
  assign new_n639 = (x06 | ~x10 | (x02 ^ x15)) & (~x15 | x10 | ~x06 | ~x02);
  assign new_n640 = ~new_n643 & (~x10 | (~new_n641 & (x04 | new_n644)));
  assign new_n641 = new_n642 & ((~x06 & x04 & x08) | (x00 & ((x04 & ~x08) | (x06 & ~x04 & x08))));
  assign new_n642 = ~x02 ^ ~x03;
  assign new_n643 = x00 & new_n581 & x02 & ~x06 & ~x08;
  assign new_n644 = (~x00 | x08 | (x03 ^ x02)) & (x06 | ~x08 | ((~x03 | ~x02) & (x00 | x03 | x02)));
  assign new_n645 = ~x07 & ~new_n646 & (~x10 | ~new_n581 | ~new_n652);
  assign new_n646 = x11 & (new_n647 | (~new_n651 & new_n446 & x00));
  assign new_n647 = ~x03 & (new_n648 | (~new_n650 & new_n75));
  assign new_n648 = new_n649 & ((~x14 & ((x06 & x04 & x02) | (~x04 & ~x02))) | (~x04 & ((~x06 & ~x02) | (x14 & x06 & x02))));
  assign new_n649 = x10 & ~x08 & x00;
  assign new_n650 = (x04 | x02 | ~x10 | x06) & (~x14 | x10 | ~x06 | ~x04 | ~x02);
  assign new_n651 = (~x02 | ~x04 | x10 | x06) & (~x10 | ~x06 | (x14 ? (x02 | x04) : (~x02 ^ x04)));
  assign new_n652 = x14 & x08 & x06 & ~x00 & new_n47;
  assign new_n653 = x00 & (new_n662 | (~new_n654 & x02));
  assign new_n654 = (~new_n660 | ~x04) & (~x10 | (new_n655 & (new_n658 | ~x04)));
  assign new_n655 = (x08 | x11 | ~new_n436) & (x04 | new_n656);
  assign new_n656 = ~new_n657 & ((~x03 & (x06 | x08)) | x11 | (x06 & x08));
  assign new_n657 = new_n278 & ~x03 & ~new_n484 & ~new_n434;
  assign new_n658 = (new_n659 | x03) & (x06 | x08 | x11 | ~x03);
  assign new_n659 = (x12 & x11) | (x06 & (x11 ? x08 : x07));
  assign new_n660 = new_n661 & ~x12 & x03;
  assign new_n661 = ~x06 & x11 & (~x08 | ~x07);
  assign new_n662 = new_n304 & x10 & (new_n663 | (new_n108 & new_n438));
  assign new_n663 = new_n278 & ((~x08 & (x04 | ~x06)) | (x04 & ~x06) | (x07 & ~x04 & x06));
  assign new_n664 = x08 & x10 & (new_n665 | (new_n668 & new_n108));
  assign new_n665 = ~x00 & (new_n667 | (~new_n666 & new_n278));
  assign new_n666 = x02 ? (x03 | x06) : ((~x03 | x06) & (x03 | ~x06 | ~new_n441 | ~x04));
  assign new_n667 = x02 & ~x11 & ~new_n581 & ~x06;
  assign new_n668 = new_n431 & x02;
  assign new_n669 = x13 & ((~new_n670 & x12) | new_n832 | new_n814);
  assign new_n670 = ~new_n774 & (~x07 | (~new_n741 & (~x09 | new_n671)));
  assign new_n671 = ~new_n738 & (new_n730 | ~x08) & (x05 | new_n672);
  assign new_n672 = ~new_n713 & (~x10 | (~new_n699 & (~x08 | new_n673)));
  assign new_n673 = ~new_n681 & ~new_n674 & (~x03 | (~new_n686 & new_n692));
  assign new_n674 = x11 & (new_n679 | (x14 & (new_n678 | new_n675)));
  assign new_n675 = ~x03 & (new_n677 | (~new_n676 & x01));
  assign new_n676 = (~x02 | ((x06 | ~x04 | (~x00 & x15)) & (~x15 | x04 | (~x06 & x00)))) & (~x15 | x02 | (x00 ^ ~x04));
  assign new_n677 = ~x01 & x15 & (x00 ? (~x02 ^ ~x04) : (~x02 ^ x04));
  assign new_n678 = ~x02 & new_n169 & (x00 ? (~x01 & ~x15) : (~x01 ^ ~x15));
  assign new_n679 = new_n160 & new_n680 & ~x00 & ~x03;
  assign new_n680 = x01 & x02;
  assign new_n681 = ~new_n55 & (new_n685 | (x03 & (new_n683 | new_n682)));
  assign new_n682 = new_n191 & ((~x01 & (~x02 ^ x00)) | (x00 & (x02 ? x06 : x01)));
  assign new_n683 = ~new_n684 & x04 & (x06 | new_n90);
  assign new_n684 = x06 & ((~x02 & x11 & (x00 | x01)) | (~x11 & (x01 ? x02 : ~x00)));
  assign new_n685 = new_n187 & (((~x02 ^ ~x04) & (x00 ^ ~x01)) | (~x00 & x01 & ~x02 & ~x04) | (x00 & ~x01 & (~x02 ^ x04)));
  assign new_n686 = x11 & ((~new_n687 & x04) | (~new_n691 & x02 & ~x04));
  assign new_n687 = (new_n690 | x00) & (~new_n688 | ~new_n51) & (new_n689 | ~x00);
  assign new_n688 = x14 & ~x06 & ~x15;
  assign new_n689 = (x02 | ((~x06 | ~x14 | x15 | ~x01) & (x01 | x14))) & (x15 | x06 | ~x14 | (~x02 & x01));
  assign new_n690 = (~x01 | x14 | x02) & (x06 | x15 | ~x14 | ~x02);
  assign new_n691 = (~x01 | ~x14 | x15 | x06) & (x00 | ((~x01 | x14) & (x15 | ~x06 | ~x14)));
  assign new_n692 = ~new_n697 & (~x15 | (~new_n693 & (new_n698 | ~new_n224)));
  assign new_n693 = ~x01 & (x00 ? new_n696 : (new_n695 | new_n694));
  assign new_n694 = ~x04 & ((~x02 & ~x11 & (x06 | x14)) | (x14 & x11 & (~x06 | x02)));
  assign new_n695 = x04 & x14 & (~x06 ^ ~x11);
  assign new_n696 = x11 & x14 & (x06 | (x04 & x02) | (~x04 & ~x02));
  assign new_n697 = x06 & new_n235 & ~x14 & ~x00 & ~x11;
  assign new_n698 = (~x06 | (~x01 & (x00 | ~x02 | ~x04))) & (~x01 | ((~x02 | ~x04) & (x00 | x02 | x04) & (~x00 | (~x02 & ~x04))));
  assign new_n699 = x00 & (new_n711 | (x11 & (~new_n707 | new_n700)));
  assign new_n700 = x14 & ((~new_n701 & x15) | (~new_n706 & new_n705 & ~x15));
  assign new_n701 = (new_n702 | x06) & (new_n704 | x08 | ~new_n703 | ~x06);
  assign new_n702 = x02 ? (~x01 | ((x04 | x03) & (x08 | ~x04 | ~x03))) : (x01 | (x04 ^ x03));
  assign new_n703 = x04 & (x03 | ~x02);
  assign new_n704 = ~x03 & x01;
  assign new_n705 = ~x08 & x04;
  assign new_n706 = (~x03 & (x02 | ~x06)) | (~x01 & (~x03 | (~x02 & ~x06)));
  assign new_n707 = (new_n710 | ~new_n149) & (new_n708 | new_n253);
  assign new_n708 = x14 ? new_n709 : ((x02 | x01) & (x06 | ~x02 | ~x01));
  assign new_n709 = (x06 | (x01 ? (~x15 | x02) : (x15 ^ x02))) & (x08 | ~x02 | ((x15 | ~x06) & (~x01 | (x15 & ~x06))));
  assign new_n710 = (x04 | x03 | x15 | x06) & (x14 | ((x06 | ~x04 | ~x03) & (x04 | x03)));
  assign new_n711 = new_n122 & x03 & (new_n712 | (new_n342 & new_n169));
  assign new_n712 = ~x08 & ((~x06 & (x15 ? (x14 & ~x04) : x04)) | (~x14 & x04) | (x06 & ~x15 & x14 & ~x04));
  assign new_n713 = ~new_n725 & x02 & (~new_n721 | (~new_n714 & x03));
  assign new_n714 = (new_n720 | ~new_n298) & (x10 | (~new_n718 & ~new_n715));
  assign new_n715 = x04 & ((~new_n717 & ~x15 & ~x06) | (~new_n716 & x06));
  assign new_n716 = (~x01 | ~x15 | ~x08 | ~x11) & (~x00 | ((x08 | x01 | ~x15) & (~x11 | (x01 & ~x15))));
  assign new_n717 = (~x11 | ~x01 | ~x08) & (x01 | (x00 ^ ~x08));
  assign new_n718 = ~new_n719 & (~x01 | x04) & (x06 ^ x15);
  assign new_n719 = (x04 | (~x00 ^ x08)) & (~x11 | ~x08 | (~x01 & x00));
  assign new_n720 = (~x00 | x08 | (x04 ? (x06 | ~x15) : (x06 ^ x15))) & (x04 | x06 | x15 | x00 | ~x08);
  assign new_n721 = x14 & (~new_n298 | (~new_n724 & ~new_n722));
  assign new_n722 = ~x03 & ((x00 & ~x08 & new_n723 & x06) | (~new_n723 & ~x06 & (x00 ^ x08)));
  assign new_n723 = x04 ^ ~x15;
  assign new_n724 = x15 & new_n75 & ~x10 & new_n169;
  assign new_n725 = ~new_n729 & ~x14 & (~x03 | (~new_n727 & ~new_n726));
  assign new_n726 = ~new_n213 & ~x01 & (x04 ? ~x10 : x11);
  assign new_n727 = new_n728 & (x08 | new_n631);
  assign new_n728 = x11 & x01 & ~x10 & x04;
  assign new_n729 = x11 & x04 & ~x03 & ~new_n213 & ~x01;
  assign new_n730 = (new_n731 | x00) & (new_n737 | x04 | ~new_n578 | ~x00);
  assign new_n731 = (new_n732 | x01) & (new_n736 | x04 | ~new_n578 | ~x01);
  assign new_n732 = (new_n733 | ~x06) & (~new_n130 | ~new_n734 | ~x10 | x06);
  assign new_n733 = (~new_n191 | new_n735) & (x10 | ~new_n342 | ~new_n734);
  assign new_n734 = x04 & x02 & x03;
  assign new_n735 = (~x15 | ((x02 | x03 | x14 | ~x10) & (~x14 | (x02 ? (x03 ^ ~x10) : (~x03 | ~x10))))) & (~x02 | x03 | ~x14 | x10 | x15);
  assign new_n736 = x02 ? (x03 | x15) : (~x03 ^ x15);
  assign new_n737 = (x01 | (x02 ? (x03 | x15) : (x03 ^ ~x15))) & (~x01 | x02 | x03 | x15);
  assign new_n738 = x11 & new_n740 & ~new_n739 & new_n252;
  assign new_n739 = ((~x02 ^ x03) | (~x01 ^ x15)) & (x02 | x03 | (~x01 ^ ~x15));
  assign new_n740 = x14 & x10 & ~x04 & x06;
  assign new_n741 = x01 & (new_n771 | (~x05 & (~new_n756 | new_n742)));
  assign new_n742 = x10 & (new_n753 | (~new_n743 & x14));
  assign new_n743 = ~new_n751 & (~x11 | (~new_n748 & (~x06 | new_n744)));
  assign new_n744 = ~new_n746 & (x09 | (~new_n745 & (~x04 | new_n747)));
  assign new_n745 = new_n83 & new_n250 & (~x15 | x00);
  assign new_n746 = new_n252 & ((~x02 & (x03 ? (~x04 & x15) : (~x04 ^ x15))) | (x02 & ~x03 & ~x04 & x15));
  assign new_n747 = (~x15 | ((~x03 | ~x00 | ~x02) & (x00 | ~x08 | x02))) & (~x03 | (~x08 & (~x00 | x15 | x02))) & (~x08 | ~x02 | (~x00 & x15));
  assign new_n748 = new_n749 & ((x00 & (~x15 ^ x08)) | (~x06 & ~x15 & x08));
  assign new_n749 = new_n581 & x02 & ~new_n750 & ~x09;
  assign new_n750 = x06 & x15;
  assign new_n751 = new_n169 & new_n752 & ~new_n213 & ~x02;
  assign new_n752 = x03 & x15 & (x08 ? ~x11 : ~x09);
  assign new_n753 = new_n755 & ~new_n754 & new_n160;
  assign new_n754 = (x06 | ~x02 | ~x08) & (~x00 | ((~x02 | x08) & (~x06 | x02 | ~x08)));
  assign new_n755 = x03 & x11;
  assign new_n756 = ~new_n769 & (~new_n401 | new_n757);
  assign new_n757 = (x09 | new_n758) & (~new_n472 | (~new_n768 & new_n765));
  assign new_n758 = (~new_n762 & x14 & ~new_n688 & ~new_n759) | (new_n764 & (~x14 | (~new_n759 & ~new_n762)));
  assign new_n759 = ~x04 & (new_n761 | (~new_n760 & (~x06 ^ ~x15)));
  assign new_n760 = (~x10 | x02 | ~x03) & (~x02 | (x03 ? x10 : ~x11));
  assign new_n761 = x15 & x11 & x06 & x02 & x03;
  assign new_n762 = new_n763 & ((x11 & (~x03 ^ ~x06)) | (~x10 & x03 & x06));
  assign new_n763 = x15 & x02 & x04;
  assign new_n764 = (~x03 | ~x04 | ~x10 | x02) & (~x02 | ((x10 | ~x03 | ~x04) & (~x11 | (~x03 ^ x04))));
  assign new_n765 = (~x03 | ~x04 | ~new_n766 | x02) & ((~x03 ^ x04) | (x02 ? ~new_n766 : new_n767));
  assign new_n766 = ~x06 & new_n55;
  assign new_n767 = x14 & (x15 | x06);
  assign new_n768 = new_n431 & ((~x14 & x02) | (~x06 & ((~x15 & x02) | (x14 & x15 & ~x02))));
  assign new_n769 = new_n770 & ((~x09 & ~x15 & x08) | (x00 & (x08 ? ~x09 : ~x15)));
  assign new_n770 = x14 & new_n370 & x02 & ~x10 & new_n581;
  assign new_n771 = ~x09 & new_n578 & (new_n772 | (~new_n773 & x02));
  assign new_n772 = ~x02 & new_n437 & (x03 ? (~x04 & x15) : (~x04 ^ x15));
  assign new_n773 = (x03 | ((~x04 | ~x00 | x08 | x15) & (~x08 | ~x15 | x04 | x00))) & (~x03 | x04 | ~x00 | x08 | x15);
  assign new_n774 = x06 & ((~new_n813 & new_n812) | (~new_n775 & ~x05));
  assign new_n775 = ~new_n804 & (x07 | (~new_n776 & new_n792));
  assign new_n776 = x11 & (new_n789 | (x10 & (~new_n781 | new_n777)));
  assign new_n777 = x08 & (new_n780 | (~new_n778 & x09));
  assign new_n778 = (new_n779 | ~x04) & (x14 | ~new_n76 | ~new_n680 | x04);
  assign new_n779 = (x02 | (x00 ? (x01 | ~x14) : (x01 ^ x14))) & (~x03 | (~x01 & x14));
  assign new_n780 = ~x00 & ~x04 & new_n704 & (~x02 ^ ~x14);
  assign new_n781 = ~new_n786 & (~x00 | (~new_n782 & (~x09 | new_n784)));
  assign new_n782 = ~new_n783 & (x02 ^ x14);
  assign new_n783 = (x03 | x01 | ~x09 | x04) & (x08 | ~x01 | (x04 ^ x03));
  assign new_n784 = (~x14 | ((~new_n431 | ~x02 | ~x01) & (~new_n785 | (~x02 & x01)))) & (~x01 | x14 | ~new_n431 | x02);
  assign new_n785 = x03 & ~x08 & x04;
  assign new_n786 = new_n263 & ((~new_n788 & x00) | (~new_n787 & x08));
  assign new_n787 = (x00 | ((~x09 | ~x02 | ~x14) & (~x01 | x02 | x14))) & (~x02 | x14 | ~x00 | ~x09) & (~x01 | (x14 ? ~x02 : ~x09));
  assign new_n788 = ((x01 ? x08 : ~x09) | (x02 ^ x14)) & (x02 | ~x14 | ~x09 | ~x01);
  assign new_n789 = new_n734 & (new_n791 | (~new_n790 & x14));
  assign new_n790 = (~x00 | ((x08 | ~x01 | x09) & (x10 | x01 | ~x09))) & (~x08 | x10 | (~x01 & ~x09));
  assign new_n791 = x08 & x01 & x09 & ~x10 & ~x14;
  assign new_n792 = (~new_n591 | ~new_n801) & (new_n803 | (~new_n796 & ~new_n793));
  assign new_n793 = (x04 ^ x14) & (new_n795 | (~new_n213 & new_n794));
  assign new_n794 = x02 & (new_n586 | new_n187);
  assign new_n795 = x10 & new_n446 & ~x02 & x00;
  assign new_n796 = x03 & (new_n797 | (~x02 & new_n800 & new_n437));
  assign new_n797 = x11 & (new_n799 | (~new_n798 & x02));
  assign new_n798 = (x04 | x14 | (~x00 ^ x08)) & (~x10 | ~x04 | ~x14 | ~x00 | ~x08);
  assign new_n799 = x14 & x10 & x08 & ~x00 & x04;
  assign new_n800 = x10 & x14;
  assign new_n801 = new_n802 & x10 & x01 & ~x00 & ~x14;
  assign new_n802 = ~x09 & x08;
  assign new_n803 = x01 ^ ~x09;
  assign new_n804 = ~x14 & ((new_n810 & new_n811) | (~new_n805 & x03));
  assign new_n805 = ~new_n809 & (~x04 | (~new_n808 & (~x08 | new_n806)));
  assign new_n806 = (~new_n636 | new_n807) & (~new_n491 | ~new_n90 | ~x09);
  assign new_n807 = (~x10 | ~x01 | x09) & (~x00 | ((~x01 | x09) & (x10 | x01 | ~x09)));
  assign new_n808 = x11 & x10 & x09 & ~new_n305 & new_n252;
  assign new_n809 = new_n810 & x02 & x01 & ~x04 & x00;
  assign new_n810 = x10 & x11 & (~x08 ^ ~x09);
  assign new_n811 = x04 & new_n602 & new_n78;
  assign new_n812 = x11 & x10 & x09 & ~x07 & new_n438;
  assign new_n813 = ((~x01 ^ ~x14) | (x00 ? (x02 | x03) : (x02 ^ ~x03))) & (x01 | ~x14 | (x00 ? (x02 ^ ~x03) : (x02 | x03))) & (x00 | ~x01 | x02 | x03 | x14);
  assign new_n814 = (x03 ^ x11) & (new_n830 | (~new_n815 & ~x05));
  assign new_n815 = ~new_n816 & (~new_n556 | (~new_n824 & ~new_n829));
  assign new_n816 = x09 & x08 & x07 & ~new_n817 & x06;
  assign new_n817 = ~new_n823 & (~x02 | (~new_n821 & (x00 | new_n818)));
  assign new_n818 = (~new_n819 | ~x04 | ~x10) & (x01 | new_n820 | x10);
  assign new_n819 = new_n48 & x12;
  assign new_n820 = (~x14 | ~x04 | x15) & (~x12 | x04 | ~x15);
  assign new_n821 = new_n822 & (new_n602 | new_n55);
  assign new_n822 = x12 & x10 & ~new_n98 & x04;
  assign new_n823 = x12 & x04 & new_n632 & new_n55 & new_n602;
  assign new_n824 = ~new_n803 & (new_n828 | (~new_n825 & x04));
  assign new_n825 = (new_n827 | ~new_n401) & (~new_n826 | ~new_n631);
  assign new_n826 = new_n48 & x07;
  assign new_n827 = (~x06 | ~x07 | x12 | ~x15) & (~x14 | ((~x06 | x07) & (~x15 | x06 | ~x07)));
  assign new_n828 = x15 & x06 & new_n352 & new_n400;
  assign new_n829 = new_n68 & ~new_n820 & new_n614;
  assign new_n830 = new_n819 & new_n288 & ~x04 & new_n831;
  assign new_n831 = x10 & x09 & new_n90 & x08;
  assign new_n832 = new_n833 & ((~x12 & ~x03 & x11) | (~x05 & x03 & ~x11));
  assign new_n833 = x09 & x08 & x07 & new_n834 & x06;
  assign new_n834 = new_n98 & new_n800 & ~x15 & new_n144;
  assign new_n835 = new_n964 & (~x09 | (~new_n836 & (~x08 | new_n916)));
  assign new_n836 = x00 & (~new_n889 | (~x05 & (~new_n871 | new_n837)));
  assign new_n837 = x03 & ((~new_n859 & x10) | (~new_n838 & x02));
  assign new_n838 = ~new_n857 & ~new_n839 & (~x10 | new_n852 | new_n846);
  assign new_n839 = ~x01 & (~new_n844 | new_n840);
  assign new_n840 = ~x08 & ((~x06 & ~new_n843) | (~new_n841 & x07));
  assign new_n841 = (x10 | ~new_n457 | ~x04) & (~new_n842 | x04);
  assign new_n842 = x11 & (~x13 | ~x12);
  assign new_n843 = (~x12 | ~x04 | x10 | x07) & (~x11 | (x04 ? x12 : x07));
  assign new_n844 = ~new_n845 & (new_n169 | x10 | ~x08);
  assign new_n845 = x11 & new_n359 & x04;
  assign new_n846 = new_n847 & (x06 ? (~x01 | new_n851) : new_n850);
  assign new_n847 = ~new_n848 & x04 & (~x07 | x01 | ~new_n343);
  assign new_n848 = ~x08 & ((~x01 & ~x11 & x06) | (new_n849 & x11 & ~x06));
  assign new_n849 = ~x07 & x12;
  assign new_n850 = x11 ? ((x12 | ~x08) & (~x01 | (x12 & (x07 | ~x08)))) : (x01 & (~x07 | ~x12 | ~x08));
  assign new_n851 = (x07 | (x11 ? x12 : ~x08)) & (~x08 | (x12 ? x13 : x11));
  assign new_n852 = ~x04 & ((new_n853 & x11) | (~new_n434 & x01 & ~x11));
  assign new_n853 = (~x01 & ~x08) | (~new_n854 & (~new_n856 | (x01 & x08)));
  assign new_n854 = ~new_n855 & x07;
  assign new_n855 = x12 & x13;
  assign new_n856 = ~x06 & ~x07;
  assign new_n857 = x01 & ~new_n858 & ~x10;
  assign new_n858 = (~x07 & x08 & x06) | (x04 & (x08 | (x07 & x06)));
  assign new_n859 = new_n860 & (~x07 | (~new_n867 & (new_n870 | new_n868)));
  assign new_n860 = (new_n863 | ~x04) & (x02 | (x04 ? new_n861 : new_n866));
  assign new_n861 = ~new_n862 & (~new_n278 | (~x08 & x01));
  assign new_n862 = new_n849 & ~x08 & ~new_n111 & ~x06;
  assign new_n863 = (new_n865 | x11 | (~x01 & ~x08)) & (~new_n864 | x01 | ~x08);
  assign new_n864 = x11 & ~x06 & new_n849;
  assign new_n865 = (x07 | x01 | ~x06) & (x02 | (x08 & x06));
  assign new_n866 = (~x08 & (~x01 ^ x11)) | (x11 & (x07 | x06));
  assign new_n867 = new_n457 & new_n144 & (x11 | new_n50);
  assign new_n868 = (new_n869 | x01) & (~new_n212 | ~x08 | ~x11 | ~x01);
  assign new_n869 = (x02 | ~x11 | x04) & (x11 | ~x04 | ~x06 | ~x08);
  assign new_n870 = x12 & x13;
  assign new_n871 = ~new_n888 & (new_n880 | new_n872 | x03);
  assign new_n872 = new_n873 & (x04 | new_n878);
  assign new_n873 = ~x01 & ~new_n874 & (x10 | ~x08 | ~x02);
  assign new_n874 = x04 & ((new_n875 & x11) | (new_n877 & (~x12 | ~x11)));
  assign new_n875 = new_n876 & (x10 | (~x08 & x02));
  assign new_n876 = x12 & (x07 ? ~x13 : ~x06);
  assign new_n877 = x10 & (x08 | x02);
  assign new_n878 = (new_n879 | ~x10) & (x02 | ~x07 | ~x08 | x10);
  assign new_n879 = (x06 | ~x02 | x07) & (~new_n278 | ~x07 | (~x08 & ~x02));
  assign new_n880 = ~new_n881 & new_n887 & (x06 | (~new_n884 & ~new_n886));
  assign new_n881 = x10 & ((~new_n882 & x11) | (~x02 & x04 & ~x11));
  assign new_n882 = (x02 | x12 | ~x04) & (new_n883 | ~x07 | (x12 ^ x04));
  assign new_n883 = (~x08 & (x02 ? ~x04 : x12)) | (x13 & (x02 ? x04 : x12));
  assign new_n884 = ~x07 & ((new_n885 & (~x02 ^ ~x08)) | (~x04 & (new_n885 | (~x02 & ~x08))));
  assign new_n885 = x10 & (new_n83 | (x04 & x11 & x12));
  assign new_n886 = x10 & new_n83 & x04 & (~x12 | ~x11);
  assign new_n887 = x01 & (x10 | (~x02 & (~x07 | x04)));
  assign new_n888 = ~x10 & new_n144 & (x08 | x01);
  assign new_n889 = ~new_n901 & ~new_n915 & (new_n456 | new_n890);
  assign new_n890 = (new_n900 | ~new_n899) & (~x02 | (~new_n896 & ~new_n891));
  assign new_n891 = ~new_n892 & x06 & (~x01 | new_n895 | new_n894);
  assign new_n892 = new_n893 & (x05 | x10 | ~x08 | ~new_n581);
  assign new_n893 = ~x01 & (x07 | ~new_n431 | ~x10);
  assign new_n894 = new_n335 & ~x10 & new_n581;
  assign new_n895 = x10 & x08 & ~x07 & ~x03 & ~x04;
  assign new_n896 = new_n897 & ~x05 & ~x03 & ~x04;
  assign new_n897 = new_n898 & (x08 | ~x01);
  assign new_n898 = x07 & x10;
  assign new_n899 = ~x04 & new_n101 & x10 & (x08 | x01);
  assign new_n900 = x07 ? x05 : ~x06;
  assign new_n901 = ~new_n902 & new_n484 & (~new_n912 | (~new_n908 & new_n472));
  assign new_n902 = new_n906 & (~new_n457 | new_n903) & (new_n905 | x10);
  assign new_n903 = (new_n904 | ~x11) & (~new_n785 | ~new_n632);
  assign new_n904 = (~x02 & (~x10 | (~x08 & x03 & x04))) | (~x03 & ~x04) | (~x10 & (x08 | (x03 & x04)));
  assign new_n905 = (x04 | x02 | ~x08 | x03) & (~new_n457 | x08 | ~x03 | ~x04 | ~x02);
  assign new_n906 = ~x01 & (new_n907 | x04 | x12 | ~x11);
  assign new_n907 = (~x02 & (~x10 | (~x03 & ~x08))) | (~x10 & (~x03 | x08));
  assign new_n908 = ~new_n910 & ~new_n909 & (new_n911 | (~x03 & ~x08));
  assign new_n909 = new_n457 & new_n263 & (x02 | new_n95);
  assign new_n910 = ~x12 & ~x04 & ~new_n446 & ~x02;
  assign new_n911 = (~x02 | x12 | x04) & (x13 | x02 | ~x12 | ~x04);
  assign new_n912 = x01 & (x10 | (~new_n913 & (~new_n83 | ~new_n914)));
  assign new_n913 = ~x02 & new_n431;
  assign new_n914 = new_n755 & ~x12 & x04;
  assign new_n915 = ~x02 & ~x10 & new_n250 & (x08 | x01);
  assign new_n916 = ~new_n955 & (x00 | (new_n939 & (x05 | new_n917)));
  assign new_n917 = ~new_n930 & (x10 ? (new_n932 | new_n918) : new_n935);
  assign new_n918 = ~new_n929 & x04 & (x03 ? new_n919 : new_n926);
  assign new_n919 = new_n920 & (~x12 | (~new_n924 & ~new_n925));
  assign new_n920 = (new_n922 & x02) | (~new_n921 & ~x02 & (x01 | new_n923));
  assign new_n921 = x01 & ((~x06 & ~x11) | (new_n457 & x07 & x11));
  assign new_n922 = (x06 | ~x11 | ~x01 | x12) & (x11 | ((x07 | ~x06) & (x12 | (x01 & ~x06))));
  assign new_n923 = (~x11 | x12) & (x13 | ~x06 | x11 | ~x12);
  assign new_n924 = ~x01 & ((x11 & x06 & ~x13 & x07) | (~x07 & ~x11 & ~x06));
  assign new_n925 = x02 & ((~x13 & ~x11 & x07) | (~x06 & (~x11 ^ ~x07)));
  assign new_n926 = (new_n305 | x11) & (new_n927 | new_n928 | ~x11);
  assign new_n927 = ~x01 & (~x02 | x12) & (x13 | ~x07 | x02 | ~x12);
  assign new_n928 = x01 & (x12 | x02) & (x13 | ~x07 | ~x12 | ~x02);
  assign new_n929 = new_n46 & x12 & new_n122 & (~x13 | ~x06);
  assign new_n930 = x11 & x02 & ~new_n931 & ~x01;
  assign new_n931 = (~new_n876 | x03 | ~x04) & (~x03 | (x04 ? x12 : ~new_n854));
  assign new_n932 = new_n934 & (new_n149 ? new_n933 : (~new_n755 | ~new_n854));
  assign new_n933 = (~x07 & ~x03) | (x11 & (new_n855 | x03));
  assign new_n934 = ~x04 & (~new_n856 | (~x02 & ~x03) | (~new_n298 & x03));
  assign new_n935 = (new_n936 | ~x02) & (new_n938 | ~x01 | x02);
  assign new_n936 = (~x04 | ~x03 | ~new_n876 | x01) & (new_n937 | (x03 ? x04 : ~x01));
  assign new_n937 = x03 & ((~x01 & (x07 | ~x11)) | (x06 & (~x07 | ~x11)));
  assign new_n938 = ~x04 & (~x07 | x03);
  assign new_n939 = new_n940 & (~x10 | new_n947);
  assign new_n940 = (new_n941 | x04) & (x07 | ~new_n944 | ~new_n946 | ~x04);
  assign new_n941 = (~x03 | new_n942) & (x07 | ~new_n217 | ~new_n945);
  assign new_n942 = ~new_n943 & (x07 | ~new_n842 | ~new_n944);
  assign new_n943 = ~x10 & x01 & (~x02 | new_n108);
  assign new_n944 = x06 & ~x01 & x02;
  assign new_n945 = ~x10 & x06;
  assign new_n946 = new_n457 & (new_n586 | new_n187);
  assign new_n947 = (~new_n457 | new_n948) & (new_n954 | ~new_n953 | ~x06);
  assign new_n948 = ~new_n950 & (~x03 | (~new_n949 & (~x11 | new_n952)));
  assign new_n949 = new_n122 & new_n386;
  assign new_n950 = new_n951 & new_n46 & (x04 ? (x01 & x02) : (x01 ^ x02));
  assign new_n951 = ~x03 & x06;
  assign new_n952 = (x07 | ~x06 | (x01 ? (x02 ^ ~x04) : (x02 ^ x04))) & (x01 | ~x07 | ~x02 | ~x04 | x06);
  assign new_n953 = ~x04 & ~x07;
  assign new_n954 = (x01 & (x02 ^ x03)) | (~x01 & (~x02 ^ x03)) | (x12 & x11) | (~x11 & x03);
  assign new_n955 = new_n956 & ((~x06 & ~new_n960) | x07 | new_n962);
  assign new_n956 = ~x05 & x01 & (~x07 | (~new_n957 & new_n581));
  assign new_n957 = ~new_n959 & (new_n472 | new_n855 | new_n958);
  assign new_n958 = ~new_n636 & (~x06 | ~new_n632);
  assign new_n959 = x02 & ((~x10 & ~x11) | (~x12 & ((x10 & x06 & x11) | (~x06 & ~x11))));
  assign new_n960 = x02 ? new_n961 : ((x03 | x04) & (~new_n613 | ~x03 | ~x04));
  assign new_n961 = (~x03 | ~x04 | x10) & (~x11 | ~x10 | ((~x03 | x04) & (~x12 | x03 | ~x04)));
  assign new_n962 = new_n963 & ((~x10 & new_n457) | ~x11 | ~x04);
  assign new_n963 = x06 & x03 & ~new_n212 & new_n556;
  assign new_n964 = ~new_n1021 & (x02 ? new_n965 : new_n1009);
  assign new_n965 = (new_n991 | ~new_n69) & (~x00 | (~new_n981 & ~new_n966));
  assign new_n966 = ~x09 & ((~new_n967 & x01) | (new_n980 & (new_n974 | ~x01)));
  assign new_n967 = ~new_n972 & (x08 | (~new_n968 & (new_n973 | ~new_n755)));
  assign new_n968 = x12 & (new_n969 | (new_n585 & new_n971));
  assign new_n969 = new_n970 & new_n856 & (x11 | new_n586);
  assign new_n970 = ~x05 & x04;
  assign new_n971 = ~new_n900 & ~x13;
  assign new_n972 = x03 & new_n970 & new_n484 & new_n278;
  assign new_n973 = (x05 | x12 | x06) & (x04 | ((x05 | x12) & (x07 | (x06 ? x12 : x05))));
  assign new_n974 = (~new_n979 & (~new_n976 | (~new_n975 & ~x05))) | (~new_n977 & ~x05 & (~new_n975 | ~new_n976));
  assign new_n975 = (~x07 & ~x03 & x10) | (x06 & ((~x03 & ~x10) | (~new_n842 & x03 & x10)));
  assign new_n976 = ~x04 & (new_n898 | ~new_n951);
  assign new_n977 = (new_n978 & x03) | (x06 & ~x03 & (~x10 | ~new_n343));
  assign new_n978 = (x10 & (~x11 | (x12 & ~x06))) | (x11 & x06 & (x13 | ~x12));
  assign new_n979 = x04 & (x03 | ~new_n945);
  assign new_n980 = x08 & (new_n970 | ~new_n452);
  assign new_n981 = x01 & (new_n988 | (x10 & (new_n990 | new_n982)));
  assign new_n982 = ~new_n983 & ~x05 & (x04 | new_n987 | new_n986);
  assign new_n983 = x04 & ((new_n984 & x11) | (~new_n951 & x08 & ~x11));
  assign new_n984 = (new_n434 | x12 | x03) & (new_n985 | x13 | ~x12 | ~x03);
  assign new_n985 = x06 ? x08 : ~x07;
  assign new_n986 = ~x03 & ~x08 & (x07 ? new_n842 : ~x06);
  assign new_n987 = ~x11 & (new_n335 | (~new_n434 & x03));
  assign new_n988 = new_n989 & new_n914 & new_n335;
  assign new_n989 = ~x05 & x06;
  assign new_n990 = ~x08 & new_n484 & new_n431 & (~x11 | ~new_n855);
  assign new_n991 = ~new_n992 & (x05 | (~new_n1007 & (~new_n581 | new_n1005)));
  assign new_n992 = new_n1000 & (~new_n998 | (~x05 & (~new_n1004 | new_n993)));
  assign new_n993 = new_n995 & (~new_n997 | new_n994 | (new_n457 & new_n898));
  assign new_n994 = new_n484 & (~x12 | new_n592);
  assign new_n995 = x11 & ((~x12 & x10) | x03 | new_n996);
  assign new_n996 = ~x09 & x12 & (x07 ? ~x13 : ~x06);
  assign new_n997 = x03 & (x06 | x09 | x12);
  assign new_n998 = x04 & (x07 | ~new_n946 | ~new_n999);
  assign new_n999 = ~x09 & x06;
  assign new_n1000 = ~x00 & ((~new_n900 & ~new_n1001) | x04 | new_n1002);
  assign new_n1001 = (~x11 | ~x03 | x09 | new_n855) & (~x10 | x03 | (new_n855 & x11));
  assign new_n1002 = ~x05 & x03 & (new_n491 | (~x09 & new_n1003));
  assign new_n1003 = x11 & ~x06 & ~x07;
  assign new_n1004 = (x11 | x03 | ~x10) & (~new_n996 | ~x03 | x10);
  assign new_n1005 = (x06 | x07 | ~new_n491) & (x09 | new_n1006);
  assign new_n1006 = (~x06 | ((~x10 | x11) & (x12 | ~x07 | ~x11))) & (~x10 | ((~x07 | x11) & (~x12 | x06 | x07 | ~x11)));
  assign new_n1007 = x10 & new_n1008 & ~x03 & ~x09;
  assign new_n1008 = ~x07 & ~x04 & ~x06;
  assign new_n1009 = (~new_n1010 | ~x01 | (~x00 ^ x08)) & (new_n1015 | ~x00 | ~x08);
  assign new_n1010 = x10 & ((~new_n1014 & new_n755) | (~new_n1011 & x12));
  assign new_n1011 = ~new_n1012 & (~new_n1013 | (x09 & x03) | (~x11 & ~x03));
  assign new_n1012 = new_n971 & ((x11 & (~x03 ^ ~x04)) | (~x09 & x03 & x04));
  assign new_n1013 = new_n856 & new_n970;
  assign new_n1014 = (x05 | (x12 & (x07 | x04 | x06))) & (x04 | ~x06 | x12 | x07);
  assign new_n1015 = (new_n1018 | ~new_n999) & (x05 | (~new_n1020 & ~new_n1016));
  assign new_n1016 = new_n1017 & ((~x03 & x07) | x04 | x01);
  assign new_n1017 = ~x09 & (~new_n898 | ~x01 | ~new_n587);
  assign new_n1018 = ~new_n1019 & (x01 | x03 | x04 | x07);
  assign new_n1019 = new_n581 & x01 & new_n898 & (~x11 | ~new_n855);
  assign new_n1020 = ~x07 & ~x06 & ~x04 & ~x01 & ~x03;
  assign new_n1021 = new_n452 & x00 & ~x04 & new_n802;
  assign z1 = ~new_n1354 | (new_n213 & (~new_n1255 | (~new_n1023 & x10)));
  assign new_n1023 = ~new_n1180 & (~x11 | new_n1024) & (new_n1218 | ~x09);
  assign new_n1024 = (new_n1025 | ~x01) & (~x09 | (~new_n1166 & (new_n1122 | x01)));
  assign new_n1025 = new_n1083 & (~x12 | new_n1026) & (new_n78 | new_n1112);
  assign new_n1026 = new_n1061 & (~x13 | (~new_n1040 & ~new_n1027 & new_n1047));
  assign new_n1027 = x07 & ((~new_n1039 & new_n212) | new_n1037 | new_n1028);
  assign new_n1028 = x09 & ((~new_n1033 & ~new_n1036 & ~x14) | (~new_n1029 & x14));
  assign new_n1029 = (new_n1030 | x15) & (new_n1031 | new_n1032 | ~x15);
  assign new_n1030 = (~x06 | ((x03 | (~x05 & (x04 | ~x02))) & (~x03 | x04 | x02) & (~x05 | (x04 & x02)))) & (x03 | ~x02 | (x05 ? x04 : (~x04 | x06)));
  assign new_n1031 = ~x02 & ((~x03 & (x06 ? x04 : ~x05)) | (x03 & ~x04 & x05 & ~x06) | (x04 & (~x05 ^ x06)));
  assign new_n1032 = (x03 | (x04 ? (~x05 ^ x06) : (~x05 | ~x06))) & x02 & (x05 | ~x06 | ~x03 | x04);
  assign new_n1033 = ~new_n1035 & x03 & (x04 | ~new_n1034);
  assign new_n1034 = ~x02 & x05;
  assign new_n1035 = x06 & x04 & (x05 ? (~x15 | ~x02) : x02);
  assign new_n1036 = ~x03 & (x05 | ~new_n212);
  assign new_n1037 = ~new_n1038 & (x03 ? ~x06 : x09);
  assign new_n1038 = ((x02 ^ ~x04) | ((~x05 | x14) & (~x15 | x05 | ~x14))) & (x05 | ((~x02 | ~x04 | x14) & (x04 | ~x14 | x15 | x02)));
  assign new_n1039 = (~x03 | x05 | x14) & (x06 | ((x03 | ~x05 | x14) & (~x15 | ~x14 | (x03 ^ x05))));
  assign new_n1040 = ~x07 & (new_n1041 | (new_n431 & new_n1045 & new_n1046));
  assign new_n1041 = x06 & (new_n1042 | (~new_n1043 & ~new_n1044 & x09));
  assign new_n1042 = ~x05 & new_n212 & (x03 ^ x14);
  assign new_n1043 = (x02 | ((~x05 | ~x14) & (x04 | (~x05 & ~x14)))) & x03 & (x04 | ~x05 | ~x14);
  assign new_n1044 = ~x03 & ((~x02 & (x14 ? ~x05 : x04)) | (x05 & x04 & ~x14) | (~x05 & ((x04 & x14) | (x02 & ~x04 & ~x14))));
  assign new_n1045 = x02 & x09;
  assign new_n1046 = ~x06 & x05;
  assign new_n1047 = (new_n1052 | new_n1059 | x09) & (new_n1048 | (x03 & ~x09));
  assign new_n1048 = (x05 & (x06 | new_n1051)) | (~new_n1049 & ~new_n1050 & ~x05);
  assign new_n1049 = new_n107 & x04 & ~x06 & x02;
  assign new_n1050 = ~new_n767 & ~new_n856 & (~x02 ^ ~x04);
  assign new_n1051 = (~x07 | ~x02 | ((x14 | ~x04) & (~x15 | ~x14 | x04))) & (x04 | x02 | (x07 & (x15 | ~x14)));
  assign new_n1052 = ~new_n1058 & ~new_n1053 & x06 & (x05 | new_n1057);
  assign new_n1053 = x14 & ((~new_n1054 & ~x07) | (~new_n1055 & ~new_n1056 & x07));
  assign new_n1054 = (~x02 & (~x03 | (~x04 & ~x05))) | (x03 & x04 & x05) | (~x03 & ~x04 & ~x05);
  assign new_n1055 = ~x03 & ((x04 & (x15 ? ~x05 : ~x02)) | (~x05 & ((~x02 & x15) | (~x04 & x02 & ~x15))));
  assign new_n1056 = x03 & ((x04 & (~x05 ^ ~x15)) | (~x05 & (x02 ? x15 : (~x04 & ~x15))));
  assign new_n1057 = (~x04 | ~x02 | x14 | ~x03) & (x04 | x02 | ~new_n384 | x03);
  assign new_n1058 = ~x14 & x05 & (x02 ? (~x03 ^ ~x04) : (~x03 ^ x04));
  assign new_n1059 = ~new_n1060 & ~x06 & (x05 | ~new_n734 | ~new_n826);
  assign new_n1060 = ~new_n432 & x05 & ((x03 & x04) | (x02 & (x03 | x04)));
  assign new_n1061 = ~new_n1081 & ((new_n1062 & ~x04) | (~new_n1072 & ~new_n1077 & x04));
  assign new_n1062 = ~new_n1067 & (x02 | (~new_n1063 & (new_n1071 | ~new_n1070)));
  assign new_n1063 = ~x13 & (new_n1066 | (~new_n1064 & new_n1065));
  assign new_n1064 = ~x03 & (x15 ? x09 : ~x14);
  assign new_n1065 = x07 & x05 & x06;
  assign new_n1066 = (x03 | x09) & (~x06 | ~x07 | ~x05) & (x06 | x07 | x05);
  assign new_n1067 = new_n200 & (new_n1068 | (~new_n1069 & new_n1065));
  assign new_n1068 = (x09 | ~x03) & (~x06 | ~x07 | ~x05) & (x06 | x07 | x05);
  assign new_n1069 = x03 & (~x09 | ~x14 | ~x15);
  assign new_n1070 = ~x03 & x05;
  assign new_n1071 = (~x07 | x14 | ~x09 | ~x06) & (x09 | ~x14 | ((~x06 | x07) & (~x15 | x06 | ~x07)));
  assign new_n1072 = ~x06 & (new_n1075 | new_n1073);
  assign new_n1073 = new_n1074 & ((x09 & (~x02 | ~x03)) | (~x02 & ~x03) | (~x09 & x02 & x03));
  assign new_n1074 = x05 ? ~x13 : ~x07;
  assign new_n1075 = new_n1076 & x09 & x07 & ~x13 & x02;
  assign new_n1076 = x03 & x05;
  assign new_n1077 = ~new_n1078 & ~x13;
  assign new_n1078 = new_n1080 & (new_n1079 | ~x09 | (x02 ^ ~x03));
  assign new_n1079 = (x05 | ~x07) & (~x06 | (x07 & (~x14 | ~x15)));
  assign new_n1080 = (~x06 | ((x05 | ~x02 | ~x03) & (x07 | x02 | x03))) & (x05 | ~x07 | (x02 ^ x03));
  assign new_n1081 = new_n55 & new_n1082 & new_n1070 & ~x13 & new_n288;
  assign new_n1082 = ~x02 & x09;
  assign new_n1083 = new_n1107 & (~x04 | (~new_n1091 & (x05 | new_n1084)));
  assign new_n1084 = ~new_n1088 & (new_n1090 | x12) & (x06 | new_n1085);
  assign new_n1085 = ~new_n1086 & (x12 | ~x03 | ~new_n1045);
  assign new_n1086 = x15 & new_n38 & ~x03 & new_n1087;
  assign new_n1087 = x07 & ~x02 & ~x09;
  assign new_n1088 = x14 & ~new_n107 & new_n1089;
  assign new_n1089 = x13 & new_n999 & ~x02 & ~x03;
  assign new_n1090 = (~new_n288 & x03 & x02) | (~x09 & ((x03 & x02) | (~new_n553 & ~x03 & ~x02)));
  assign new_n1091 = x05 & (~new_n1095 | new_n1092) & (new_n1102 | ~new_n1106);
  assign new_n1092 = ~x12 & (new_n1094 | (~new_n1093 & x06));
  assign new_n1093 = (~x02 | ~x03 | x09) & (~x09 | ((~new_n55 | x02 | ~x03) & (x13 | (x02 & (~new_n55 | ~x03)))));
  assign new_n1094 = new_n1045 & new_n70 & new_n448;
  assign new_n1095 = x07 & (x03 | (~new_n1099 & (~x06 | new_n1096)));
  assign new_n1096 = (~new_n1097 | x09 | x02) & (~new_n1098 | (x02 ? ~x09 : ~x14));
  assign new_n1097 = ~x12 & (x15 ? ~x13 : x14);
  assign new_n1098 = x13 & (~x14 | (~x12 & x15));
  assign new_n1099 = new_n1101 & ((x13 & ~x14) | (~x06 & ~new_n1100 & x14));
  assign new_n1100 = x15 ? x12 : ~x13;
  assign new_n1101 = ~x02 & ~x09;
  assign new_n1102 = x06 & ((~new_n1103 & x13) | new_n1105 | new_n1104);
  assign new_n1103 = (x02 | x14 | x03 | x09) & (x12 | ~x03 | ~x09 | ~x02 | ~x14);
  assign new_n1104 = ~x12 & ((x03 & ~x09) | (~x02 & (x14 | x09)));
  assign new_n1105 = x02 & ((~x13 & x09 & x03) | (~x12 & ~x09 & ~x03));
  assign new_n1106 = ~x07 & (x06 | x09 | ~new_n101 | ~x13);
  assign new_n1107 = (x12 | new_n1108) & (~new_n1111 | (~x09 & x02));
  assign new_n1108 = (new_n1110 | ~new_n642) & (new_n235 | new_n1109 | ~x09 | new_n642);
  assign new_n1109 = ~new_n1046 & (x04 | new_n900);
  assign new_n1110 = (~x05 & ~x07 & ~x06) | (x07 & x06 & x09 & x05) | (x04 & (~x05 | (~x07 & x06)));
  assign new_n1111 = x03 & new_n953 & ~x05 & ~x06;
  assign new_n1112 = ~new_n1120 & (~x04 | (~new_n1119 & (~x05 | new_n1113)));
  assign new_n1113 = ~new_n1116 & (~x06 | (~new_n1114 & (new_n1118 | ~new_n1115)));
  assign new_n1114 = x13 & x07 & x09 & ~new_n55 & ~x12;
  assign new_n1115 = x12 & (x13 | (x07 & (~x09 | ~new_n55)));
  assign new_n1116 = new_n1117 & ((x09 & (~x07 | ~x15)) | (x07 & x15 & ~x09));
  assign new_n1117 = ~x06 & x13 & x12 & (x14 | ~x07);
  assign new_n1118 = x13 & ((x07 & (~x14 | (x15 & ~x09))) | (x14 & x09 & (~x15 | ~x07)) | (~x14 & ~x09));
  assign new_n1119 = new_n312 & new_n989 & ((x09 & (~x07 | ~x15)) | (x07 & x15 & ~x09));
  assign new_n1120 = new_n1121 & x09 & x07 & ~x04 & ~x12;
  assign new_n1121 = x05 & x06;
  assign new_n1122 = (new_n1123 | x12) & (new_n1163 | x05) & (new_n1132 | ~x12);
  assign new_n1123 = (new_n1131 | x04) & (new_n1124 | ~x04) & (~new_n78 | ~new_n1046);
  assign new_n1124 = (new_n1125 | x02) & (new_n1130 | ~new_n1076) & (new_n1129 | ~x02);
  assign new_n1125 = new_n1126 & (~x05 | (new_n1128 & (~x07 | new_n1127)));
  assign new_n1126 = (~new_n288 | ~new_n503 | x03) & (x05 | (~new_n553 & ~x03));
  assign new_n1127 = (~x14 | ((~x06 | (x13 ^ x15)) & (x03 | ~x15) & (x06 | ~x13 | x15))) & (x03 | ((~x06 | ~x15) & (~x13 | x14)));
  assign new_n1128 = (~x03 & (x07 | (~x13 & ~x06))) | (x07 & x13 & ~x06) | (x06 & (x14 ? x03 : (~x07 & ~x13)));
  assign new_n1129 = (x03 | x05) & (~new_n36 | ~x06 | ~x07 | ~x05);
  assign new_n1130 = (~x06 | ((~x14 | (~x15 ^ x13)) & (x07 | (x13 & ~x14)))) & (~x07 | ~x15 | ~x13 | ~x14 | x06);
  assign new_n1131 = (~x06 & (x05 ? x02 : ~x07)) | (x02 & x03 & (~x07 | ~x05)) | (~x03 & (~x02 | (x07 & x05)));
  assign new_n1132 = ~new_n1161 & (x07 ? new_n1133 : new_n1152);
  assign new_n1133 = (new_n1134 | x14) & (new_n1149 | x13) & (new_n1140 | ~x14);
  assign new_n1134 = ~new_n1138 & (~x13 | (new_n1135 & (x02 | new_n1139)));
  assign new_n1135 = ~new_n1136 & ~new_n1137 & (~new_n587 | (x05 & x15));
  assign new_n1136 = x02 & (x03 ? (~x04 & x05) : (~x04 ^ x05));
  assign new_n1137 = ~x06 & ((x04 & x03 & x02) | (x05 & ~x03 & ~x02));
  assign new_n1138 = new_n1121 & ((~x13 & x04 & x03) | (~x04 & (~x02 ^ ~x03)));
  assign new_n1139 = (x05 | (x03 ^ ~x04)) & (~x06 | ((x03 | ~x05) & (~x15 | (x04 ^ x05))));
  assign new_n1140 = ~new_n1146 & (~x05 | (~new_n1141 & new_n1143));
  assign new_n1141 = new_n1142 & (~x02 | ~x03 | ~x04) & (x02 | x03 | x04);
  assign new_n1142 = x06 ? (x13 ^ x15) : (x13 & x15);
  assign new_n1143 = (x06 | ~new_n1144 | ~new_n101) & (new_n1145 | (~new_n581 & ~new_n101));
  assign new_n1144 = ~x04 & x15;
  assign new_n1145 = x15 ? (~x06 | ~x13) : (~x06 ^ x13);
  assign new_n1146 = x13 & ((~new_n1147 & ~x04) | (~new_n1148 & ~x05 & x04));
  assign new_n1147 = ((x03 ^ x15) | (x02 ? x05 : ~x06)) & (x05 | x02 | (~x03 ^ x15)) & (x03 | ~x15 | ~x06 | ~x02);
  assign new_n1148 = (x02 & ((x06 & x03 & x15) | (~x03 & ~x15))) | (~x06 & ((x03 & ~x15) | (~x02 & ~x03 & x15)));
  assign new_n1149 = ~new_n1151 & (x05 ? (~new_n750 | ~new_n913) : new_n1150);
  assign new_n1150 = ~new_n587 & (x02 | new_n253);
  assign new_n1151 = x02 & ((~x06 & x04 & x03) | (~x05 & ~x04 & ~x03));
  assign new_n1152 = new_n1153 & (~x06 | (~new_n1160 & (~x02 | new_n1159)));
  assign new_n1153 = ~new_n1157 & ((~new_n1158 & new_n1154) | x02 | new_n1156);
  assign new_n1154 = ~new_n1155 & x06 & (~x05 | ~x04 | ~new_n38);
  assign new_n1155 = (x03 | x04) & (~x13 | ~x14) & (~x05 | ~x04);
  assign new_n1156 = ~x06 & ~new_n970 & (~x13 | ~new_n1070);
  assign new_n1157 = x13 & x05 & new_n448 & x04;
  assign new_n1158 = ~x03 & ((x05 & (x13 ^ x14)) | (~x04 & x13 & x14));
  assign new_n1159 = (~x04 | x13 | ~x03) & (x03 | ((x14 & x13) ? ~x05 : x04));
  assign new_n1160 = x13 & x03 & (x04 ? (x05 ^ x14) : (x05 & x14));
  assign new_n1161 = x05 & ~new_n1162 & ~x13;
  assign new_n1162 = (x02 | ((x14 | x03 | ~x04) & (x06 | (~x03 ^ x04)))) & (x06 | ~x02 | x03 | x04);
  assign new_n1163 = ~new_n1164 & (x04 | x07 | ~new_n448);
  assign new_n1164 = new_n1165 & ((x06 & ~x07) | (x15 & ~x06 & x07));
  assign new_n1165 = x14 & ~x03 & new_n246;
  assign new_n1166 = x02 & (new_n1170 | (~new_n1167 & ~x05 & x12));
  assign new_n1167 = (~x13 | new_n1168) & (x07 | ~x04 | ~new_n448);
  assign new_n1168 = (new_n1169 | ~x06) & (~new_n826 | ~x03 | ~x04 | x06);
  assign new_n1169 = (x07 | ~x03 | ~x04 | x14) & (~x14 | ((x15 & x07) ? (~x03 | ~x04) : (x03 ^ ~x04)));
  assign new_n1170 = new_n1176 & (~x04 | new_n1171 | (~new_n1179 & ~x07));
  assign new_n1171 = ~new_n1172 & x07 & (~x06 | new_n1175 | new_n1174);
  assign new_n1172 = ~x06 & (x13 ? new_n1173 : (x12 | ~x03));
  assign new_n1173 = (x15 | ((~x03 | x12) & (~x14 | x03 | ~x12))) & (~x03 | ((x14 | x12) & (~x15 | ~x14 | ~x12)));
  assign new_n1174 = x03 & ((~x14 & ((x15 & x12 & x13) | (~x12 & ~x13))) | (~x15 & ~x12 & ~x13) | (x14 & (x15 ? (~x12 ^ ~x13) : (x12 & x13))));
  assign new_n1175 = ~x03 & ((~x12 & (~x13 | (~x15 & x14))) | (x12 & x15 & x14 & x13) | (~x13 & (~x15 | ~x14)));
  assign new_n1176 = x05 & (~new_n1177 | (~new_n1178 & x03 & x12));
  assign new_n1177 = ~x04 & (~new_n321 | ~new_n951);
  assign new_n1178 = (x15 | ((~x14 | x06 | ~x13) & (~x07 | ~x06 | x13))) & (x14 | (x07 ? (~x06 | x13) : ~x13)) & (~x13 | ((x07 | x06) & (~x15 | ~x14 | ~x07 | ~x06)));
  assign new_n1179 = (~x13 | ((x14 | (x12 ? x03 : ~x06)) & (~x12 | ((~x14 | ~x03 | ~x06) & (x03 | x06))))) & (x13 | ~x12 | ~x03 | x06) & (x03 | ~x06 | x12);
  assign new_n1180 = ~new_n1213 & x01 & (~x03 | new_n1204 | new_n1181);
  assign new_n1181 = ~x11 & (~new_n1196 | new_n1182 | (~new_n1199 & ~new_n399));
  assign new_n1182 = x04 & (new_n1194 | (~new_n1189 & ~x02) | (~new_n1183 & x02));
  assign new_n1183 = ~new_n1188 & (x05 ? new_n1184 : new_n1187);
  assign new_n1184 = (~new_n1185 & x09 & ~x06) | (x06 & (~x12 | new_n1186));
  assign new_n1185 = new_n384 & new_n312;
  assign new_n1186 = ~new_n1118 & (x13 | ~x09 | ~x07);
  assign new_n1187 = x09 & (x06 ? ~new_n1185 : x07);
  assign new_n1188 = ~x12 & ((~x06 & x09 & x07 & ~x05) | (x05 & x06 & ~x09));
  assign new_n1189 = (new_n1190 | ~x09) & (~x13 | (~new_n1193 & (~new_n1192 | x09)));
  assign new_n1190 = (new_n1185 & (~x05 ^ ~x06)) | (new_n1191 & x05 & x06);
  assign new_n1191 = (x07 | (x12 & x13 & x14)) & (~x15 | ~x12 | ~x13 | ~x14 | ~x07);
  assign new_n1192 = (x14 & ~x05 & (new_n384 ^ x06)) | (x05 & (~x14 | (new_n384 & x06) | (~new_n384 & ~x06)));
  assign new_n1193 = new_n599 & ((x05 & x06 & ~x07) | (x15 & x07 & (x05 ^ x06)));
  assign new_n1194 = x12 & x05 & ~new_n1195 & new_n614;
  assign new_n1195 = ~new_n48 & x13;
  assign new_n1196 = ~new_n1197 & (new_n511 | ~new_n1065 | ~new_n1082);
  assign new_n1197 = ~x04 & ((x02 & ~x09) | (~new_n1121 & x09) | (~new_n1198 & (x09 ? ~x02 : new_n1121)));
  assign new_n1198 = ~new_n1185 & (~x09 | x07);
  assign new_n1199 = ~new_n1200 & (~new_n55 | ~new_n1046 | ~new_n1087);
  assign new_n1200 = x06 & ((~new_n1201 & x07) | (new_n1034 & new_n1203 & ~x07));
  assign new_n1201 = (new_n1202 | ~x15) & (x09 | ~new_n1034 | ~x14 | x15);
  assign new_n1202 = (x09 | x02 | (~x05 ^ x13)) & (~x14 | ~x09 | ~x02 | ~x05 | ~x13);
  assign new_n1203 = ~x09 & x14;
  assign new_n1204 = x12 & ((~new_n1210 & new_n1101) | (~new_n1205 & x05));
  assign new_n1205 = ~new_n1207 & (~x06 | (~new_n1206 & (~x02 | new_n1209)));
  assign new_n1206 = new_n953 & x13 & ~x14 & ~x02 & ~x09;
  assign new_n1207 = new_n1101 & ((~x06 & ~x13 & x04) | (~new_n1208 & x13 & ~x04));
  assign new_n1208 = (x15 & x07 & x14) | (x06 & (~x07 | x14));
  assign new_n1209 = (x13 | x07 | ~x04 | x09) & (x14 | x04 | ~x09 | ~x13 | ~x07);
  assign new_n1210 = (new_n1211 | ~x04) & (x05 | ~new_n106 | ~x13 | x04);
  assign new_n1211 = x07 ? (x05 | (new_n767 & x13)) : new_n1212;
  assign new_n1212 = (x14 & x06 & x13) | (x05 & (~x06 | x13));
  assign new_n1213 = ~x03 & ~new_n1214 & (x11 | ~new_n1082 | new_n1217);
  assign new_n1214 = x02 & ((~new_n1216 & ~x11) | (~new_n1215 & ~x06));
  assign new_n1215 = (x11 | ~x05) & (x07 | x09 | x04 | x05);
  assign new_n1216 = (x05 & x04 & x09 & ~x07) | (~x06 & (x05 | (~x07 & ~x04)));
  assign new_n1217 = new_n856 & ~x04 & ~x05;
  assign new_n1218 = new_n1246 & (x11 | (~new_n1235 & (~new_n452 | new_n1219)));
  assign new_n1219 = (new_n1232 | ~x04) & (new_n1220 | ~new_n1228);
  assign new_n1220 = new_n1221 & (~x12 | (~new_n1226 & (x04 | new_n1227)));
  assign new_n1221 = x06 & (~x04 | (new_n1222 & (x05 | new_n1225)));
  assign new_n1222 = ~new_n1223 & (~x05 | (~new_n36 & (x12 | ~new_n1224)));
  assign new_n1223 = ~new_n107 & x14 & (x05 ? ~x12 : x13);
  assign new_n1224 = x15 & ~x13 & x07;
  assign new_n1225 = (~x12 | (x14 & x13)) & (~x13 | x12 | ~x07 | ~x15);
  assign new_n1226 = x13 & x07 & new_n55 & x05;
  assign new_n1227 = (~x15 & ((~x13 & x07) | (~x14 & ~x05))) | (~x05 & (~x13 | ~x07)) | (~x14 & ~x13 & ~x07) | (x15 & x14 & x05 & x13 & x07);
  assign new_n1228 = ~x02 & ((x05 & new_n1231) | x06 | new_n1229);
  assign new_n1229 = x04 & (new_n1230 | (new_n351 & x05));
  assign new_n1230 = new_n353 & ((x13 & (~x05 ^ ~x15)) | (~x12 & x05 & x15));
  assign new_n1231 = x12 & x07 & ~x04 & new_n55;
  assign new_n1232 = (new_n1233 | ~x12) & (~new_n552 | ~x05 | ~x15 | x12);
  assign new_n1233 = (new_n1234 & x05) | (~new_n856 & ~x05 & (~x14 | ~new_n553));
  assign new_n1234 = (~x14 | ~x06 | ~x13 | (x15 & x07)) & (~x07 | ((~x06 | x13) & (x06 | ~x13 | ~x15 | ~x14)));
  assign new_n1235 = ~new_n1243 & x02 & (~new_n1236 | (~new_n1240 & x04));
  assign new_n1236 = ~new_n1237 & x03 & (x01 | new_n1239);
  assign new_n1237 = new_n1238 & (~new_n1195 | ~new_n1065 | ~x12);
  assign new_n1238 = ~x04 & (~x01 | new_n1121);
  assign new_n1239 = (x06 | ~new_n970 | x12) & (~new_n36 | ~new_n1065 | ~x12);
  assign new_n1240 = x07 ? new_n1242 : ((~x05 & ~x06) | (new_n1241 & x05 & x06));
  assign new_n1241 = new_n38 & x12;
  assign new_n1242 = x05 ? ((new_n55 & x13 & (x06 ^ x12)) | (x06 & x12 & (~new_n55 | ~x13))) : ((~x06 & ~x12) | (new_n55 & x13 & x06 & x12));
  assign new_n1243 = new_n1245 & (x01 | (~new_n1244 & (x04 | new_n900)));
  assign new_n1244 = ~new_n484 & x05;
  assign new_n1245 = ~x03 & (~x04 | (x01 & ~x05) | (~new_n484 & x05));
  assign new_n1246 = (~new_n1253 | ~x02) & (new_n1247 | x01 | ~x03 | x02);
  assign new_n1247 = ~new_n1250 & (new_n1248 | new_n1251 | ~x12);
  assign new_n1248 = ~new_n1249 & x04 & (x13 | x07 | ~x05);
  assign new_n1249 = ~x06 & x07 & (~x13 | (~x05 & ~new_n55));
  assign new_n1250 = x07 & x04 & new_n36 & new_n1046;
  assign new_n1251 = ~x04 & (x13 ? new_n1252 : (~new_n1065 | ~new_n48));
  assign new_n1252 = (x07 | ((~x05 | x06) & (~x14 | x05 | ~x06))) & (x06 | ((~x14 | x05 | ~x15 | ~x07) & (~x05 | (x15 & x14))));
  assign new_n1253 = new_n1254 & new_n431;
  assign new_n1254 = ~x05 & new_n856;
  assign new_n1255 = (new_n1326 | ~new_n680) & (~x09 | (~new_n1279 & ~new_n1256));
  assign new_n1256 = x01 & ((new_n1254 & new_n913) | (~new_n1257 & ~x10));
  assign new_n1257 = new_n1269 & (~x05 | (new_n1276 & (~x03 | new_n1258)));
  assign new_n1258 = (new_n1259 | ~x02) & (new_n1263 | ~x04 | (new_n484 & ~x02));
  assign new_n1259 = ~new_n1260 & (x06 | ~new_n343 | ~x07);
  assign new_n1260 = ~x04 & ((~new_n1262 & new_n287) | (~new_n288 & (new_n1261 | ~new_n287)));
  assign new_n1261 = ~x06 & (~x07 | (~new_n1100 & new_n287 & x14));
  assign new_n1262 = (~x13 | ((x14 | (~x06 & ~x07)) & (~x15 | ~x06 | ~x07))) & (~x06 | x07 | x13);
  assign new_n1263 = new_n1265 & (~x12 | (new_n1267 & (~x07 | new_n1264)));
  assign new_n1264 = (x06 & ~x11) | (~new_n36 & (new_n1195 | (~x06 & x11)));
  assign new_n1265 = x02 & (x06 | ~new_n121) & (x12 | new_n1266);
  assign new_n1266 = (~new_n55 | ~x13 | ~x06 | ~x07) & (x11 | (~x06 & ~x07));
  assign new_n1267 = ~new_n1268 & (new_n388 | (x06 & x11) | (~x06 & ~x11));
  assign new_n1268 = x13 & x06 & ((~x11 & ~x14) | (~x07 & x11 & x14));
  assign new_n1269 = (x05 | new_n1270) & (~new_n1275 | (x02 & ~new_n108));
  assign new_n1270 = ~new_n1271 & (x02 ? x03 : new_n938);
  assign new_n1271 = new_n1274 & (new_n1272 | new_n1273 | new_n1261 | ~x04);
  assign new_n1272 = ~new_n856 & (~x11 | (x12 & (~x14 | ~x13)));
  assign new_n1273 = new_n313 & (~x12 | (x06 & new_n55 & x13));
  assign new_n1274 = x02 & (x04 | (x06 ? (~x07 | x11) : (x07 | ~x11)));
  assign new_n1275 = ~x04 & (x03 | new_n484);
  assign new_n1276 = (~new_n1278 | ~x06) & (x03 | (x06 & (new_n1277 | ~x02)));
  assign new_n1277 = ~new_n953 & new_n413 & (~new_n313 | ~new_n312 | new_n1144);
  assign new_n1278 = (x04 | x07) & (~x02 | new_n343) & (~x03 | ~x07);
  assign new_n1279 = x02 & ((~new_n1316 & x03) | (~new_n1280 & ~x01));
  assign new_n1280 = new_n1281 & (x10 | (new_n1307 & (~x04 | new_n1292)));
  assign new_n1281 = ~new_n1291 & (~x11 | new_n1282 | (~new_n1285 & new_n1289));
  assign new_n1282 = x03 & (x04 ? (x12 | x05) : new_n1283);
  assign new_n1283 = ~new_n1284 & (new_n855 | (~new_n1046 & new_n900));
  assign new_n1284 = new_n870 & ~x05 & ~new_n767 & ~new_n856;
  assign new_n1285 = x13 & ((~new_n1286 & x07) | (~new_n1288 & x12 & ~x07));
  assign new_n1286 = (new_n1287 | ~x12) & (~new_n1121 | ~new_n55 | ~x04 | x12);
  assign new_n1287 = (x14 | ((~x04 | x05) & (x06 | x04 | ~x05))) & (x06 | ((~x14 | ~x15 | x04 | x05) & (x15 | (~x04 ^ x05))));
  assign new_n1288 = x05 ? (x04 | x06) : (~x06 | (~x14 ^ x04));
  assign new_n1289 = ~x03 & (~x12 | (~new_n1013 & (x13 | new_n1290)));
  assign new_n1290 = (~x05 | ((~x04 | x07) & (x04 | ~x07 | ~new_n48 | ~x06))) & (~x04 | (x07 ? (x05 & x06) : ~x06));
  assign new_n1291 = new_n1241 & new_n1076 & new_n1144 & ~x11 & new_n288;
  assign new_n1292 = new_n1302 & (~x07 | (new_n1299 & (~x14 | new_n1293)));
  assign new_n1293 = ~new_n1296 & (~x06 | (~new_n1294 & (~x11 | new_n1298)));
  assign new_n1294 = x13 & ~new_n1295 & x03;
  assign new_n1295 = (~x05 | x12 | ~x15) & (x11 | (x15 ? ~x12 : x05));
  assign new_n1296 = new_n376 & ((new_n1297 & (~x05 ^ x15)) | (~new_n93 & (~x05 ^ ~x15)));
  assign new_n1297 = x12 & (x15 ? x11 : x03);
  assign new_n1298 = (x15 | ((~x05 | ~x13 | ~x12) & (x03 | (~x13 & (~x05 | x12))))) & (x05 | ~x13 | ~x12 | ~x15);
  assign new_n1299 = (~x03 | new_n1301) & (new_n1300 | ~x05 | ~x11);
  assign new_n1300 = (~new_n457 | ~x06) & (x03 | ~new_n36);
  assign new_n1301 = (~x05 | ~x13 | x11 | x14) & (~x12 | (x13 ? x14 : x05));
  assign new_n1302 = ~new_n1304 & (~x03 | (~new_n1303 & (~x12 | new_n1306)));
  assign new_n1303 = x13 & new_n121 & ((x05 & (~x06 | ~x14)) | (x06 & x14 & ~x05));
  assign new_n1304 = ~new_n1305 & new_n346 & (x06 | new_n1070);
  assign new_n1305 = x06 & ((x03 & (~x05 | ~x14)) | (~x05 & ~x14) | (~x12 & x05 & x14));
  assign new_n1306 = (x07 & (~x05 | x06)) | (x13 & (x05 | (x14 & x06)));
  assign new_n1307 = (new_n1310 | ~new_n870) & (new_n1308 | new_n399);
  assign new_n1308 = ~new_n1309 & (new_n93 | (new_n536 & x05) | (~new_n553 & ~x05));
  assign new_n1309 = x03 & new_n1121 & new_n48 & new_n52;
  assign new_n1310 = ~new_n1314 & (x04 | (~new_n1311 & (~x03 | new_n1315)));
  assign new_n1311 = x06 & (new_n1313 | (~new_n1312 & x11));
  assign new_n1312 = (~x07 | ~x14 | (x15 ^ x03)) & (~x05 | x03 | x14);
  assign new_n1313 = x03 & ((~x15 & ~x05 & x14) | (~x07 & (~x05 ^ ~x14)));
  assign new_n1314 = x15 & new_n224 & ~x03 & new_n1065;
  assign new_n1315 = (~x07 | ((x14 | ~x05) & (~x15 | ~x14 | x06 | x05))) & (x06 | ~x05 | (x15 & x07));
  assign new_n1316 = ~new_n1317 & (x07 | ~new_n1046 | ~x04 | ~new_n278);
  assign new_n1317 = ~x10 & ((~new_n1318 & x05) | (~new_n1325 & x11 & ~x05));
  assign new_n1318 = ~new_n1319 & (new_n1234 | x11 | ~x04 | ~x12);
  assign new_n1319 = new_n1320 & (~x06 | new_n1324 | (~new_n1323 & x07));
  assign new_n1320 = x11 & (~new_n1322 | (~new_n1321 & x07));
  assign new_n1321 = (x12 | ~x04) & (~x13 | ~x14 | ((x15 | ~x04) & (~x12 | ~x15 | x04)));
  assign new_n1322 = ~x06 & (x07 | ~x04 | ~x12 | ~x13);
  assign new_n1323 = (x13 & ((~x14 & x12) | (x15 & ((~x04 & x12) | (x14 & x04 & ~x12))))) | (x04 & x12 & (~x15 | ~x13));
  assign new_n1324 = ~x07 & ((~x12 & x04) | (x13 & ((~x14 & x04) | (x12 & x14 & ~x04))));
  assign new_n1325 = ~new_n1008 & (~new_n419 | ~new_n514);
  assign new_n1326 = (new_n1352 | ~new_n370) & (x09 | (new_n1343 & ~new_n1327));
  assign new_n1327 = ~x10 & (~new_n1328 | (x03 & (new_n1341 | new_n1332)));
  assign new_n1328 = ~new_n1329 & (new_n1331 | new_n93 | new_n399);
  assign new_n1329 = x04 & ~new_n1330 & new_n334;
  assign new_n1330 = (x03 | ~new_n1192) & (~new_n819 | ~new_n1065);
  assign new_n1331 = x05 ? new_n516 : ~new_n553;
  assign new_n1332 = x12 & (new_n1338 | (x04 & (new_n1334 | ~new_n1333)));
  assign new_n1333 = ~new_n1254 & x13;
  assign new_n1334 = (new_n1335 | new_n1337 | x05) & (new_n1003 | new_n1336 | ~x05);
  assign new_n1335 = ~new_n767 & x07;
  assign new_n1336 = new_n353 & ((x11 & (x15 | ~x06)) | (~x11 & ~x15 & x06) | (x15 & ~x06));
  assign new_n1337 = x06 & (x14 ? (x11 | (x15 & x07)) : ~x07);
  assign new_n1338 = x13 & ((~new_n1339 & x05) | (~x04 & new_n106 & ~x05));
  assign new_n1339 = (new_n1340 | x04) & (~new_n484 | ~new_n224);
  assign new_n1340 = x14 & ((x07 & x15 & ~x06) | (x06 & (~x07 | (~x11 & ~x15))));
  assign new_n1341 = x04 & ((~x12 & new_n1121 & x11) | (new_n1342 & ~x11));
  assign new_n1342 = new_n1192 & x13;
  assign new_n1343 = ~new_n1344 & (~new_n1241 | ~new_n121 | ~new_n581 | ~new_n1121);
  assign new_n1344 = x11 & ((~new_n1351 & x03) | (~new_n1345 & x12));
  assign new_n1345 = ~new_n1346 & (new_n1333 | new_n1217 | new_n253);
  assign new_n1346 = ~new_n1347 & x13 & (~new_n1350 | (~new_n1349 & x14));
  assign new_n1347 = ~x07 & (x06 ? new_n1348 : (~x05 | ~new_n431));
  assign new_n1348 = (x03 | x04 | x05 | ~x14) & (x14 | (x03 ? (x04 ^ x05) : (~x04 ^ x05)));
  assign new_n1349 = ((~x04 ^ ~x15) | (x03 ? (x05 | x06) : (x05 ^ ~x06))) & (x04 | ~x15 | (x03 ? (x05 ^ ~x06) : (x05 | x06))) & (x03 | ~x04 | x05 | x06 | x15);
  assign new_n1350 = x07 & ((x03 & (~x04 ^ ~x05)) | x14 | (~x03 & (~x04 ^ x05)));
  assign new_n1351 = (x04 | (x12 & (x06 | x05 | x07))) & (x12 | (x06 & (x05 | ~x07)));
  assign new_n1352 = ~new_n1353 & (x05 | x07 | x12 | ~new_n581);
  assign new_n1353 = new_n870 & new_n1070 & ~x10 & new_n404;
  assign new_n1354 = new_n1355 & (~new_n401 | (~new_n1372 & (x01 | new_n1369)));
  assign new_n1355 = ~new_n1356 & ((~new_n1361 & new_n1365) | new_n803 | new_n213);
  assign new_n1356 = ~new_n803 & ~new_n594 & ~new_n213 & ~new_n1357 & ~new_n93;
  assign new_n1357 = (x12 & (new_n1358 | x04)) | (~x05 & new_n856 & ~x12 & ~x04) | (new_n1358 & x04 & (x05 | ~new_n856));
  assign new_n1358 = ~new_n1359 & (x13 | (~new_n856 & x05) | (new_n856 & ~x05));
  assign new_n1359 = ~new_n1360 & ((x06 & ~x14 & ~x07) | (x07 & ((~x06 & ~x14) | (~x15 & (~x06 | ~x14)))));
  assign new_n1360 = x05 ^ ~x13;
  assign new_n1361 = ~x04 & ((~new_n1362 & ~x02) | (~new_n1364 & ~x10 & x02));
  assign new_n1362 = (new_n900 & ~x03) | (x10 & (x03 ? ~new_n1363 : x11));
  assign new_n1363 = new_n121 & ~x05 & ~x06;
  assign new_n1364 = (x07 | ~x06 | x03 | x11) & (x05 | ((x11 | x07 | x06) & (x03 | (x11 & (x07 | x06)))));
  assign new_n1365 = (new_n1366 | ~x05) & (~new_n1367 | ~x04 | x05);
  assign new_n1366 = (~x07 & x06) ? (~new_n1367 | ~x04) : new_n1368;
  assign new_n1367 = (~x10 & ~x03 & ~x11) | (~x02 & (~x10 | (~x03 & ~x11)));
  assign new_n1368 = (~x04 | x02 | x10) & (x03 | ((x02 | x10) & (x11 | (x02 & x10))));
  assign new_n1369 = (~new_n1254 | ~new_n913) & (x09 | (new_n1371 & ~new_n1370));
  assign new_n1370 = ~x02 & ((~x05 & x04) | (~x03 & ~new_n900 & ~x04));
  assign new_n1371 = ~x02 & ((~x05 & (~x03 | x04)) | (new_n484 & ~x03 & ~x04));
  assign new_n1372 = new_n101 & new_n1254 & x01 & ~x04 & ~x09;
  assign z2 = ~new_n1408 | (new_n803 & (~new_n1389 | (~new_n1374 & x11)));
  assign new_n1374 = ~new_n1375 & new_n1385 & (new_n1388 | (~x02 & ~x10));
  assign new_n1375 = x13 & (~new_n1376 | (new_n106 & (new_n1384 | new_n1382)));
  assign new_n1376 = ~new_n1377 & (new_n1381 | ~new_n856 | ~x05);
  assign new_n1377 = ~new_n1378 & ((x07 & (~x15 ^ x06)) | (~x14 & (x06 | x07)));
  assign new_n1378 = ~new_n1379 & (new_n594 | x03 | ~x04 | ~x05);
  assign new_n1379 = x12 & ((x02 & x10) | ((x02 | x10) & (~x03 ^ new_n1380)));
  assign new_n1380 = x04 ^ ~x05;
  assign new_n1381 = (~x02 & (~x10 | (~x04 & x03))) | (~x04 & (~x12 | (~x10 & x03))) | (~x12 & (x03 | (x02 & x10)));
  assign new_n1382 = x12 & ((x02 & x10) | ((x02 | x10) & (~x03 ^ new_n1383)));
  assign new_n1383 = ~x04 ^ ~x05;
  assign new_n1384 = new_n556 & x04 & ~x03 & ~x05;
  assign new_n1385 = ~new_n1386 & ((~x02 & (~x03 | ~x10)) | new_n1387 | (~x03 & ~x10));
  assign new_n1386 = x12 & x10 & x02 & ~new_n1333 & new_n581;
  assign new_n1387 = (~x05 & new_n856 & ~x04) | (x12 & (x13 | x04));
  assign new_n1388 = ~new_n1111 & (new_n1333 | x03 | ~x04 | ~x12);
  assign new_n1389 = new_n1404 & ((new_n1390 & x05) | (~new_n1395 & ~new_n1402 & ~x05));
  assign new_n1390 = new_n1391 & (new_n1394 | new_n594 | ~x03 | ~x13);
  assign new_n1391 = ~new_n1392 & (x07 | ~new_n491 | ~x02 | ~new_n169);
  assign new_n1392 = ~new_n484 & (new_n590 | (~new_n1393 & ~new_n250 & x02));
  assign new_n1393 = (x11 | ~x10) & (~x03 | ~new_n457 | x10);
  assign new_n1394 = (~x12 | (new_n106 ^ x04)) & (x11 | new_n106 | ~x04);
  assign new_n1395 = ~new_n1400 & x02 & (~x04 | new_n491 | new_n1396);
  assign new_n1396 = new_n586 & (new_n876 | (~new_n1397 & x13));
  assign new_n1397 = ~new_n1398 & (~new_n484 | (x11 & x14) | (~x12 & ~x14));
  assign new_n1398 = ~new_n1399 & x07 & (~new_n224 | ~new_n173);
  assign new_n1399 = ~x12 & (~x14 | (x06 & x15) | (~x06 & ~x15));
  assign new_n1400 = ~new_n1401 & ~x04 & (~new_n586 | ~new_n870 | ~new_n106);
  assign new_n1401 = ~x03 & x10 & (new_n856 | new_n52);
  assign new_n1402 = new_n304 & x10 & (new_n1403 | (new_n876 & x04));
  assign new_n1403 = x13 & ((~new_n1397 & x04) | (new_n106 & x12 & ~x04));
  assign new_n1404 = (~x03 | new_n1405) & (~new_n484 | ~new_n491 | ~new_n668);
  assign new_n1405 = ~new_n1407 & (~x02 | (~new_n1406 & (x04 | ~new_n491)));
  assign new_n1406 = new_n457 & new_n169 & ~x07 & ~x10;
  assign new_n1407 = x10 & new_n457 & new_n169 & ~x02 & ~x07;
  assign new_n1408 = (new_n1409 | new_n803) & (~new_n593 | (new_n803 ? new_n1331 : new_n1358));
  assign new_n1409 = (x02 & x10) | (~new_n1253 & ((~x02 & ~x10) ? new_n1410 : new_n1411));
  assign new_n1410 = ~x07 & ~x05 & ~new_n1275 & ~x04;
  assign new_n1411 = ~new_n1412 & (x11 | (~new_n1111 & (x03 | new_n1217)));
  assign new_n1412 = ~new_n93 & ~x12 & ((~x05 & new_n856 & x04) | (~x04 & (x05 | ~new_n856)));
  assign z3 = new_n1422 | new_n1414 | (new_n556 & (new_n1412 | ~new_n1423));
  assign new_n1414 = new_n594 & ((~new_n1415 & x03) | (~new_n1421 & x11 & ~x03));
  assign new_n1415 = (new_n1420 & ~new_n278 & x04) | (new_n1416 & ~x04 & (~new_n1244 | ~new_n278));
  assign new_n1416 = (~new_n1417 | ~x11) & (~x12 | (~new_n1342 & (new_n1418 | ~x11)));
  assign new_n1417 = ~new_n1244 & (new_n856 | ~new_n870);
  assign new_n1418 = (new_n1419 | ~x13) & (new_n484 | ~x05 | x13);
  assign new_n1419 = (~x07 & (~x06 | (x14 & ~x05))) | (x15 & ((x14 & ~x06 & ~x05) | (x07 & x06 & x05))) | (~x14 & x05) | (~x15 & ((~x06 & x05) | (x14 & x06 & ~x05)));
  assign new_n1420 = (new_n1419 & new_n1333 & ~new_n1342) | (~x12 & (x11 | ~new_n1342));
  assign new_n1421 = (~x04 & (~x12 | ~new_n1342)) | (~new_n1342 & (~x12 | (new_n1333 & new_n1419)));
  assign new_n1422 = ~new_n93 & ~new_n399 & (new_n556 ? ~new_n1358 : ~new_n1331);
  assign new_n1423 = (~new_n1217 & x11 & ~x03) | (x03 & (x04 | ~new_n1363));
  assign z4 = new_n1425 | new_n1426 | (~new_n1421 & (x03 | ~x11) & (~x03 | x11));
  assign new_n1425 = ~new_n399 & ((~new_n1331 & (~x03 ^ x11)) | (~new_n1358 & (x03 ^ x11)));
  assign new_n1426 = ~new_n93 & ((~x04 & ~x12) | (new_n1254 & (~x04 | ~x12)));
  assign z5 = ~new_n1428 & (new_n1359 | new_n1431 | new_n399);
  assign new_n1428 = new_n399 & (x05 ? new_n1429 : (~x13 | new_n1430));
  assign new_n1429 = new_n516 & (~x13 | new_n106);
  assign new_n1430 = (~x14 | ~x07 | ~x15) & (~x06 | (~x14 & (~x07 | ~x15)));
  assign new_n1431 = (~x05 & ~x13) | (new_n856 & (~x05 | ~x13));
  assign z6 = ~new_n1360 ^ ~new_n1430;
  assign z7 = new_n384 ? (~x06 ^ x14) : (x06 ^ x14);
  assign z8 = ~x07 ^ ~x15;
endmodule


