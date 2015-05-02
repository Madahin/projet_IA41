:- module(data,[node/7, target/4]).


%	node(id, x, y, upid, rightid, downid, leftid)
:- dynamic(node/7).
% line 1
node(1   , 0   , 0   , 0   , 5   , 33  , 0  ).
node(2   , 1   , 0   , 0   , 5   , 50  , 1  ).
node(3   , 2   , 0   , 0   , 5   , 19  , 1  ).
node(4   , 3   , 0   , 0   , 5   , 116 , 1  ).
node(5   , 4   , 0   , 0   , 0   , 245 , 1  ).
node(6   , 5   , 0   , 0   , 10  , 86  , 0  ).
node(7   , 6   , 0   , 0   , 10  , 55  , 6  ).
node(8   , 7   , 0   , 0   , 10  , 104 , 6  ).
node(9   , 8   , 0   , 0   , 10  , 105 , 6  ).
node(10  , 9   , 0   , 0   , 0   , 186 , 6  ).
node(11  , 10  , 0   , 0   , 16  , 107 , 0  ).
node(12  , 11  , 0   , 0   , 16  , 44  , 11 ).
node(13  , 12  , 0   , 0   , 16  , 141 , 11 ).
node(14  , 13  , 0   , 0   , 16  , 110 , 11 ).
node(15  , 14  , 0   , 0   , 16  , 0   , 11 ).
node(16  , 15  , 0   , 0   , 0   , 32  , 11 ).

% line 2
node(17  , 0   , 1   , 1   , 19  , 33  , 0  ).
node(18  , 1   , 1   , 2   , 19  , 50  , 17 ).
node(19  , 2   , 1   , 3   , 0   , 0   , 17 ).
node(20  , 3   , 1   , 4   , 30  , 116 , 0  ).
node(21  , 4   , 1   , 5   , 30  , 245 , 20 ).
node(22  , 5   , 1   , 6   , 30  , 86  , 20 ).
node(23  , 6   , 1   , 7   , 30  , 55  , 20 ).
node(24  , 7   , 1   , 8   , 30  , 104 , 20 ).
node(25  , 8   , 1   , 9   , 30  , 105 , 20 ).
node(26  , 9   , 1   , 10  , 30  , 186 , 20 ).
node(27  , 10  , 1   , 11  , 30  , 107 , 20 ).
node(28  , 11  , 1   , 12  , 30  , 44  , 20 ).
node(29  , 12  , 1   , 13  , 30  , 141 , 20 ).
node(30  , 13  , 1   , 14  , 0   , 110 , 20 ).
node(31  , 14  , 1   , 0   , 32  , 223 , 0  ).
node(32  , 15  , 1   , 16  , 0   , 0   , 31 ).

% line 3
node(33  , 0   , 2   , 1   , 43  , 0   , 0  ).
node(34  , 1   , 2   , 2   , 43  , 50  , 33 ).
node(35  , 2   , 2   , 0   , 43  , 243 , 33 ).
node(36  , 3   , 2   , 4   , 43  , 116 , 33 ).
node(37  , 4   , 2   , 5   , 43  , 245 , 33 ).
node(38  , 5   , 2   , 6   , 43  , 86  , 33 ).
node(39  , 6   , 2   , 7   , 43  , 55  , 33 ).
node(40  , 7   , 2   , 8   , 43  , 104 , 33 ).
node(41  , 8   , 2   , 9   , 43  , 105 , 33 ).
node(42  , 9   , 2   , 10  , 43  , 186 , 33 ).
node(43  , 10  , 2   , 11  , 0   , 107 , 33 ).
node(44  , 11  , 2   , 12  , 48  , 0   , 0  ).
node(45  , 12  , 2   , 13  , 48  , 141 , 44 ).
node(46  , 13  , 2   , 14  , 48  , 110 , 44 ).
node(47  , 14  , 2   , 31  , 48  , 223 , 44 ).
node(48  , 15  , 2   , 0   , 0   , 64  , 44 ).

% line 4
node(49  , 0   , 3   , 0   , 0   , 65  , 0  ).
node(50  , 1   , 3   , 2   , 64  , 0   , 0  ).
node(51  , 2   , 3   , 35  , 64  , 243 , 50 ).
node(52  , 3   , 3   , 4   , 64  , 116 , 50 ).
node(53  , 4   , 3   , 5   , 64  , 245 , 50 ).
node(54  , 5   , 3   , 6   , 64  , 86  , 50 ).
node(55  , 6   , 3   , 7   , 64  , 0   , 50 ).
node(56  , 7   , 3   , 8   , 64  , 104 , 50 ).
node(57  , 8   , 3   , 9   , 64  , 105 , 50 ).
node(58  , 9   , 3   , 10  , 64  , 186 , 50 ).
node(59  , 10  , 3   , 11  , 64  , 107 , 50 ).
node(60  , 11  , 3   , 0   , 64  , 236 , 50 ).
node(61  , 12  , 3   , 13  , 64  , 141 , 50 ).
node(62  , 13  , 3   , 14  , 64  , 110 , 50 ).
node(63  , 14  , 3   , 31  , 64  , 223 , 50 ).
node(64  , 15  , 3   , 48  , 0   , 0   , 50 ).

% line 5
node(65  , 0   , 4   , 49  , 70  , 0   , 0  ).
node(66  , 1   , 4   , 0   , 70  , 210 , 65 ).
node(67  , 2   , 4   , 35  , 70  , 243 , 65 ).
node(68  , 3   , 4   , 4   , 70  , 116 , 65 ).
node(69  , 4   , 4   , 5   , 70  , 245 , 65 ).
node(70  , 5   , 4   , 6   , 0   , 86  , 65 ).
node(71  , 6   , 4   , 0   , 80  , 215 , 0  ).
node(72  , 7   , 4   , 8   , 80  , 104 , 71 ).
node(73  , 8   , 4   , 9   , 80  , 105 , 71 ).
node(74  , 9   , 4   , 10  , 80  , 186 , 71 ).
node(75  , 10  , 4   , 11  , 80  , 107 , 71 ).
node(76  , 11  , 4   , 60  , 80  , 236 , 71 ).
node(77  , 12  , 4   , 13  , 80  , 141 , 71 ).
node(78  , 13  , 4   , 14  , 80  , 110 , 71 ).
node(79  , 14  , 4   , 31  , 80  , 223 , 71 ).
node(80  , 15  , 4   , 0   , 0   , 256 , 71 ).

% line 6
node(81  , 0   , 5   , 0   , 96  , 241 , 0  ).
node(82  , 1   , 5   , 66  , 96  , 210 , 81 ).
node(83  , 2   , 5   , 35  , 96  , 243 , 81 ).
node(84  , 3   , 5   , 4   , 96  , 116 , 81 ).
node(85  , 4   , 5   , 5   , 96  , 245 , 81 ).
node(86  , 5   , 5   , 6   , 96  , 0   , 81 ).
node(87  , 6   , 5   , 71  , 96  , 215 , 81 ).
node(88  , 7   , 5   , 8   , 96  , 104 , 81 ).
node(89  , 8   , 5   , 9   , 96  , 105 , 81 ).
node(90  , 9   , 5   , 10  , 96  , 186 , 81 ).
node(91  , 10  , 5   , 11  , 96  , 107 , 81 ).
node(92  , 11  , 5   , 60  , 96  , 236 , 81 ).
node(93  , 12  , 5   , 13  , 96  , 141 , 81 ).
node(94  , 13  , 5   , 14  , 96  , 110 , 81 ).
node(95  , 14  , 5   , 31  , 96  , 223 , 81 ).
node(96  , 15  , 5   , 80  , 0   , 256 , 81 ).

% line 7
node(97  , 0   , 6   , 81  , 102 , 241 , 0  ).
node(98  , 1   , 6   , 66  , 102 , 210 , 97 ).
node(99  , 2   , 6   , 35  , 102 , 243 , 97 ).
node(100 , 3   , 6   , 4   , 102 , 116 , 97 ).
node(101 , 4   , 6   , 5   , 102 , 245 , 97 ).
node(102 , 5   , 6   , 0   , 0   , 166 , 97 ).
node(103 , 6   , 6   , 71  , 110 , 215 , 0  ).
node(104 , 7   , 6   , 8   , 110 , 0   , 103).
node(105 , 8   , 6   , 9   , 110 , 0   , 103).
node(106 , 9   , 6   , 10  , 110 , 186 , 103).
node(107 , 10  , 6   , 11  , 110 , 0   , 103).
node(108 , 11  , 6   , 60  , 110 , 236 , 103).
node(109 , 12  , 6   , 13  , 110 , 141 , 103).
node(110 , 13  , 6   , 14  , 0   , 0   , 103).
node(111 , 14  , 6   , 31  , 112 , 223 , 0  ).
node(112 , 15  , 6   , 80  , 0   , 256 , 111).

% line 8
node(113 , 0   , 7   , 81  , 116 , 241 , 0  ).
node(114 , 1   , 7   , 66  , 116 , 210 , 113).
node(115 , 2   , 7   , 35  , 116 , 243 , 113).
node(116 , 3   , 7   , 4   , 0   , 0   , 113).
node(117 , 4   , 7   , 5   , 119 , 245 , 0  ).
node(118 , 5   , 7   , 102 , 119 , 166 , 117).
node(119 , 6   , 7   , 71  , 0   , 215 , 117).
node(120 , 7   , 7   , 0   , 0   , 0   , 0  ).
node(121 , 8   , 7   , 0   , 0   , 0   , 0  ).
node(122 , 9   , 7   , 10  , 123 , 186 , 0  ).
node(123 , 10  , 7   , 0   , 0   , 251 , 122).
node(124 , 11  , 7   , 60  , 128 , 236 , 0  ).
node(125 , 12  , 7   , 13  , 128 , 141 , 124).
node(126 , 13  , 7   , 0   , 128 , 254 , 124).
node(127 , 14  , 7   , 31  , 128 , 223 , 124).
node(128 , 15  , 7   , 80  , 0   , 256 , 124).
 
% line 9 
node(129 , 0   , 8   , 81  , 135 , 243 , 0  ).
node(130 , 1   , 8   , 66  , 135 , 210 , 129).
node(131 , 2   , 8   , 35  , 135 , 243 , 129).
node(132 , 3   , 8   , 0   , 135 , 148 , 129).
node(133 , 4   , 8   , 5   , 135 , 245 , 129).
node(134 , 5   , 8   , 102 , 135 , 166 , 129).
node(135 , 6   , 8   , 71  , 0   , 214 , 129).
node(136 , 7   , 8   , 0   , 0   , 0   , 0  ).
node(137 , 8   , 8   , 0   , 0   , 0   , 0  ).
node(138 , 9   , 8   , 10  , 144 , 186 , 0  ).
node(139 , 10  , 8   , 123 , 144 , 251 , 138).
node(140 , 11  , 8   , 60  , 144 , 236 , 138).
node(141 , 12  , 8   , 13  , 144 , 0   , 138).
node(142 , 13  , 8   , 126 , 144 , 254 , 138).
node(143 , 14  , 8   , 31  , 144 , 223 , 138).
node(144 , 15  , 8   , 80  , 0   , 256 , 138).

% line 10
node(145 , 0   , 9   , 81  , 148 , 241 , 0  ).
node(146 , 1   , 9   , 66  , 148 , 210 , 145).
node(147 , 2   , 9   , 35  , 148 , 243 , 145).
node(148 , 3   , 9   , 132 , 0   , 0   , 145).
node(149 , 4   , 9   , 5   , 157 , 245 , 0).
node(150 , 5   , 9   , 102 , 157 , 166 , 149).
node(151 , 6   , 9   , 71  , 157 , 215 , 149).
node(152 , 7   , 9   , 0   , 157 , 248 , 149).
node(153 , 8   , 9   , 0   , 157 , 249 , 149).
node(154 , 9   , 9   , 10  , 157 , 186 , 149).
node(155 , 10  , 9   , 123 , 157 , 251 , 149).
node(156 , 11  , 9   , 60  , 157 , 236 , 149).
node(157 , 12  , 9   , 0   , 0   , 253 , 149).
node(158 , 13  , 9   , 126 , 160 , 254 , 0  ).
node(159 , 14  , 9   , 31  , 160 , 223 , 158).
node(160 , 15  , 9   , 80  , 0   , 256 , 158).

% line 11
node(161 , 0   , 10  , 81  , 176 , 241 , 0  ).
node(162 , 1   , 10  , 66  , 176 , 210 , 161).
node(163 , 2   , 10  , 35  , 176 , 243 , 161).
node(164 , 3   , 10  , 0   , 176 , 244 , 161).
node(165 , 4   , 10  , 5   , 176 , 245 , 161).
node(166 , 5   , 10  , 102 , 176 , 0   , 161).
node(167 , 6   , 10  , 71  , 176 , 215 , 161).
node(168 , 7   , 10  , 152 , 176 , 248 , 161).
node(169 , 8   , 10  , 153 , 176 , 249 , 161).
node(170 , 9   , 10  , 10  , 176 , 186 , 161).
node(171 , 10  , 10  , 123 , 176 , 251 , 161).
node(172 , 11  , 10  , 60  , 176 , 236 , 161).
node(173 , 12  , 10  , 157 , 176 , 253 , 161).
node(174 , 13  , 10  , 126 , 176 , 254 , 161).
node(175 , 14  , 10  , 31  , 176 , 223 , 161).
node(176 , 15  , 10  , 80  , 0   , 256 , 161).
 
% line 12
node(177 , 0   , 11  , 81  , 181 , 241 , 0  ).
node(178 , 1   , 11  , 66  , 181 , 210 , 177).
node(179 , 2   , 11  , 35  , 181 , 243 , 177).
node(180 , 3   , 11  , 164 , 181 , 244 , 177).
node(181 , 4   , 11  , 5   , 0   , 245 , 177).
node(182 , 5   , 11  , 0   , 192 , 246 , 0  ).
node(183 , 6   , 11  , 71  , 192 , 215 , 182).
node(184 , 7   , 11  , 152 , 192 , 248 , 182).
node(185 , 8   , 11  , 153 , 192 , 249 , 182).
node(186 , 9   , 11  , 10  , 192 , 0   , 182).
node(187 , 10  , 11  , 123 , 192 , 251 , 182).
node(188 , 11  , 11  , 60  , 192 , 236 , 182).
node(189 , 12  , 11  , 157 , 192 , 253 , 182).
node(190 , 13  , 11  , 126 , 192 , 254 , 182).
node(191 , 14  , 11  , 31  , 192 , 223 , 182).
node(192 , 15  , 11  , 80  , 0   , 256 , 182).

% line 13
node(193 , 0   , 12  , 81  , 201 , 241 , 0  ).
node(194 , 1   , 12  , 66  , 201 , 210 , 193).
node(195 , 2   , 12  , 35  , 201 , 243 , 193).
node(196 , 3   , 12  , 164 , 201 , 244 , 193).
node(197 , 4   , 12  , 5   , 201 , 245 , 193).
node(198 , 5   , 12  , 182 , 201 , 246 , 193).
node(199 , 6   , 12  , 71  , 201 , 215 , 193).
node(200 , 7   , 12  , 152 , 201 , 248 , 193).
node(201 , 8   , 12  , 153 , 0   , 249 , 193).
node(202 , 9   , 12  , 0   , 208 , 250 , 0  ).
node(203 , 10  , 12  , 123 , 208 , 251 , 202).
node(204 , 11  , 12  , 60  , 208 , 236 , 202).
node(205 , 12  , 12  , 157 , 208 , 253 , 202).
node(206 , 13  , 12  , 126 , 208 , 254 , 202).
node(207 , 14  , 12  , 31  , 208 , 223 , 202).
node(208 , 15  , 12  , 80  , 0   , 256 , 202).

% line 14
node(209 , 0   , 13  , 81  , 0   , 241 , 0  ).
node(210 , 1   , 13  , 66  , 222 , 0   , 0  ).
node(211 , 2   , 13  , 35  , 222 , 243 , 210).
node(212 , 3   , 13  , 164 , 222 , 244 , 210).
node(213 , 4   , 13  , 5   , 222 , 245 , 210).
node(214 , 5   , 13  , 182 , 222 , 246 , 210).
node(215 , 6   , 13  , 71  , 222 , 0   , 210).
node(216 , 7   , 13  , 152 , 222 , 248 , 210).
node(217 , 8   , 13  , 153 , 222 , 249 , 210).
node(218 , 9   , 13  , 202 , 222 , 250 , 210).
node(219 , 10  , 13  , 123 , 222 , 251 , 210).
node(220 , 11  , 13  , 60  , 222 , 236 , 210).
node(221 , 12  , 13  , 157 , 222 , 253 , 210).
node(222 , 13  , 13  , 126 , 0   , 254 , 210).
node(223 , 14  , 13  , 31  , 224 , 0   , 0  ).
node(224 , 15  , 13  , 80  , 0   , 256 , 223).


% line 15
node(225 , 0   , 14  , 81  , 231 , 241 , 0  ).
node(226 , 1   , 14  , 0   , 231 , 242 , 225).
node(227 , 2   , 14  , 35  , 231 , 243 , 225).
node(228 , 3   , 14  , 164 , 231 , 244 , 225).
node(229 , 4   , 14  , 5   , 231 , 245 , 225).
node(230 , 5   , 14  , 182 , 231 , 246 , 225).
node(231 , 6   , 14  , 0   , 0   , 247 , 225).
node(232 , 7   , 14  , 152 , 236 , 248 , 0  ).
node(233 , 8   , 14  , 153 , 236 , 249 , 232).
node(234 , 9   , 14  , 202 , 236 , 250 , 232).
node(235 , 10  , 14  , 123 , 236 , 251 , 232).
node(236 , 11  , 14  , 60  , 0   , 0   , 232).
node(237 , 12  , 14  , 157 , 240 , 253 , 0  ).
node(238 , 13  , 14  , 126 , 240 , 254 , 237).
node(239 , 14  , 14  , 0   , 240 , 255 , 237).
node(240 , 15  , 14  , 80  , 0   , 256 , 237).
 
% line 16
node(241 , 0   , 15  , 81  , 245 , 0   , 0  ).
node(242 , 1   , 15  , 226 , 245 , 0   , 241).
node(243 , 2   , 15  , 35  , 245 , 0   , 241).
node(244 , 3   , 15  , 164 , 245 , 0   , 241).
node(245 , 4   , 15  , 5   , 0   , 0   , 241).
node(246 , 5   , 15  , 182 , 254 , 0   , 0  ).
node(247 , 6   , 15  , 231 , 254 , 0   , 246).
node(248 , 7   , 15  , 152 , 254 , 0   , 246).
node(249 , 8   , 15  , 153 , 254 , 0   , 246).
node(250 , 9   , 15  , 202 , 254 , 0   , 246).
node(251 , 10  , 15  , 123 , 254 , 0   , 246).
node(252 , 11  , 15  , 0   , 254 , 0   , 246).
node(253 , 12  , 15  , 157 , 254 , 0   , 246).
node(254 , 13  , 15  , 126 , 0   , 0   , 246).
node(255 , 14  , 15  , 239 , 256 , 0   , 0  ).
node(256 , 15  , 15  , 80  , 0   , 0   , 255).

% Format : target(TargetID, X, Y, RobotColor)
% RobotColor : all=0, blue=1, green=2, yellow=3, red=4
target(0 , 3   , 7  , 0).
target(1 , 5   , 6  , 1).
target(2 , 12  , 9  , 1).
target(3 , 11  , 2  , 1).
target(4 , 3   , 9  , 1).
target(5 , 13  , 6  , 2).
target(6 , 1   , 3  , 2).
target(7 , 6   , 14 , 2).
target(8 , 14  , 13 , 2).
target(9 , 1   , 13 , 3).
target(10, 10  , 7  , 3).
target(11, 9   , 12 , 3).
target(12, 6   , 4  , 3).
target(13, 11  , 14 , 4).
target(14, 5   , 11 , 4).
target(15, 2   , 1  , 4).
target(16, 14  , 1  , 4).


