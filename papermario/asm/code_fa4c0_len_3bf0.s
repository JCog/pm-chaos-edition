
.section .text802D5B10, "ax"

/* 0FA4C0 802D5B10 27BDFFC0 */  addiu $sp, $sp, -0x40
/* 0FA4C4 802D5B14 27A40010 */  addiu $a0, $sp, 0x10
/* 0FA4C8 802D5B18 27A50014 */  addiu $a1, $sp, 0x14
/* 0FA4CC 802D5B1C AFBF0038 */  sw    $ra, 0x38($sp)
/* 0FA4D0 802D5B20 AFB70034 */  sw    $s7, 0x34($sp)
/* 0FA4D4 802D5B24 AFB60030 */  sw    $s6, 0x30($sp)
/* 0FA4D8 802D5B28 AFB5002C */  sw    $s5, 0x2c($sp)
/* 0FA4DC 802D5B2C AFB40028 */  sw    $s4, 0x28($sp)
/* 0FA4E0 802D5B30 AFB30024 */  sw    $s3, 0x24($sp)
/* 0FA4E4 802D5B34 AFB20020 */  sw    $s2, 0x20($sp)
/* 0FA4E8 802D5B38 AFB1001C */  sw    $s1, 0x1c($sp)
/* 0FA4EC 802D5B3C 0C015823 */  jal   func_8005608C
/* 0FA4F0 802D5B40 AFB00018 */   sw    $s0, 0x18($sp)
/* 0FA4F4 802D5B44 8FA20014 */  lw    $v0, 0x14($sp)
/* 0FA4F8 802D5B48 10400036 */  beqz  $v0, .L802D5C24
/* 0FA4FC 802D5B4C 0000982D */   daddu $s3, $zero, $zero
/* 0FA500 802D5B50 3C1700FF */  lui   $s7, 0xff
/* 0FA504 802D5B54 2416FFFF */  addiu $s6, $zero, -1
/* 0FA508 802D5B58 3C15802E */  lui   $s5, 0x802e
/* 0FA50C 802D5B5C 26B5B7D8 */  addiu $s5, $s5, -0x4828
/* 0FA510 802D5B60 3C14802E */  lui   $s4, 0x802e
/* 0FA514 802D5B64 2694B800 */  addiu $s4, $s4, -0x4800
.L802D5B68:
/* 0FA518 802D5B68 8FA20010 */  lw    $v0, 0x10($sp)
/* 0FA51C 802D5B6C 8C430000 */  lw    $v1, ($v0)
/* 0FA520 802D5B70 3C04802E */  lui   $a0, 0x802e
/* 0FA524 802D5B74 8C84B7D0 */  lw    $a0, -0x4830($a0)
/* 0FA528 802D5B78 00771024 */  and   $v0, $v1, $s7
/* 0FA52C 802D5B7C 00022C02 */  srl   $a1, $v0, 0x10
/* 0FA530 802D5B80 8C820000 */  lw    $v0, ($a0)
/* 0FA534 802D5B84 10560009 */  beq   $v0, $s6, .L802D5BAC
/* 0FA538 802D5B88 306300FF */   andi  $v1, $v1, 0xff
/* 0FA53C 802D5B8C 2406FFFF */  addiu $a2, $zero, -1
/* 0FA540 802D5B90 8C820000 */  lw    $v0, ($a0)
.L802D5B94:
/* 0FA544 802D5B94 10450005 */  beq   $v0, $a1, .L802D5BAC
/* 0FA548 802D5B98 00000000 */   nop   
/* 0FA54C 802D5B9C 24840014 */  addiu $a0, $a0, 0x14
/* 0FA550 802D5BA0 8C820000 */  lw    $v0, ($a0)
/* 0FA554 802D5BA4 1446FFFB */  bne   $v0, $a2, .L802D5B94
/* 0FA558 802D5BA8 00000000 */   nop   
.L802D5BAC:
/* 0FA55C 802D5BAC 50800017 */  beql  $a0, $zero, .L802D5C0C
/* 0FA560 802D5BB0 26730001 */   addiu $s3, $s3, 1
/* 0FA564 802D5BB4 00031080 */  sll   $v0, $v1, 2
/* 0FA568 802D5BB8 00821021 */  addu  $v0, $a0, $v0
/* 0FA56C 802D5BBC 00058880 */  sll   $s1, $a1, 2
/* 0FA570 802D5BC0 02359021 */  addu  $s2, $s1, $s5
/* 0FA574 802D5BC4 8E430000 */  lw    $v1, ($s2)
/* 0FA578 802D5BC8 8C500004 */  lw    $s0, 4($v0)
/* 0FA57C 802D5BCC 10600004 */  beqz  $v1, .L802D5BE0
/* 0FA580 802D5BD0 02341021 */   addu  $v0, $s1, $s4
/* 0FA584 802D5BD4 8C440000 */  lw    $a0, ($v0)
/* 0FA588 802D5BD8 0C0B102B */  jal   func_802C40AC
/* 0FA58C 802D5BDC 00000000 */   nop   
.L802D5BE0:
/* 0FA590 802D5BE0 5200000A */  beql  $s0, $zero, .L802D5C0C
/* 0FA594 802D5BE4 26730001 */   addiu $s3, $s3, 1
/* 0FA598 802D5BE8 0200202D */  daddu $a0, $s0, $zero
/* 0FA59C 802D5BEC 24050001 */  addiu $a1, $zero, 1
/* 0FA5A0 802D5BF0 0C0B0CF8 */  jal   func_802C33E0
/* 0FA5A4 802D5BF4 0000302D */   daddu $a2, $zero, $zero
/* 0FA5A8 802D5BF8 AE420000 */  sw    $v0, ($s2)
/* 0FA5AC 802D5BFC 8C430144 */  lw    $v1, 0x144($v0)
/* 0FA5B0 802D5C00 02341021 */  addu  $v0, $s1, $s4
/* 0FA5B4 802D5C04 AC430000 */  sw    $v1, ($v0)
/* 0FA5B8 802D5C08 26730001 */  addiu $s3, $s3, 1
.L802D5C0C:
/* 0FA5BC 802D5C0C 8FA20010 */  lw    $v0, 0x10($sp)
/* 0FA5C0 802D5C10 8FA30014 */  lw    $v1, 0x14($sp)
/* 0FA5C4 802D5C14 24420004 */  addiu $v0, $v0, 4
/* 0FA5C8 802D5C18 0263182B */  sltu  $v1, $s3, $v1
/* 0FA5CC 802D5C1C 1460FFD2 */  bnez  $v1, .L802D5B68
/* 0FA5D0 802D5C20 AFA20010 */   sw    $v0, 0x10($sp)
.L802D5C24:
/* 0FA5D4 802D5C24 0C01582A */  jal   func_800560A8
/* 0FA5D8 802D5C28 00000000 */   nop   
/* 0FA5DC 802D5C2C 3C04802E */  lui   $a0, 0x802e
/* 0FA5E0 802D5C30 24849D30 */  addiu $a0, $a0, -0x62d0
/* 0FA5E4 802D5C34 8C830000 */  lw    $v1, ($a0)
/* 0FA5E8 802D5C38 24630001 */  addiu $v1, $v1, 1
/* 0FA5EC 802D5C3C AC830000 */  sw    $v1, ($a0)
/* 0FA5F0 802D5C40 8FBF0038 */  lw    $ra, 0x38($sp)
/* 0FA5F4 802D5C44 8FB70034 */  lw    $s7, 0x34($sp)
/* 0FA5F8 802D5C48 8FB60030 */  lw    $s6, 0x30($sp)
/* 0FA5FC 802D5C4C 8FB5002C */  lw    $s5, 0x2c($sp)
/* 0FA600 802D5C50 8FB40028 */  lw    $s4, 0x28($sp)
/* 0FA604 802D5C54 8FB30024 */  lw    $s3, 0x24($sp)
/* 0FA608 802D5C58 8FB20020 */  lw    $s2, 0x20($sp)
/* 0FA60C 802D5C5C 8FB1001C */  lw    $s1, 0x1c($sp)
/* 0FA610 802D5C60 8FB00018 */  lw    $s0, 0x18($sp)
/* 0FA614 802D5C64 0000102D */  daddu $v0, $zero, $zero
/* 0FA618 802D5C68 03E00008 */  jr    $ra
/* 0FA61C 802D5C6C 27BD0040 */   addiu $sp, $sp, 0x40

/* 0FA620 802D5C70 27BDFFE8 */  addiu $sp, $sp, -0x18
/* 0FA624 802D5C74 AFBF0010 */  sw    $ra, 0x10($sp)
/* 0FA628 802D5C78 8C82000C */  lw    $v0, 0xc($a0)
/* 0FA62C 802D5C7C 0C0B1EAF */  jal   func_802C7ABC
/* 0FA630 802D5C80 8C450000 */   lw    $a1, ($v0)
/* 0FA634 802D5C84 0000282D */  daddu $a1, $zero, $zero
/* 0FA638 802D5C88 3C04802E */  lui   $a0, 0x802e
/* 0FA63C 802D5C8C 2484B800 */  addiu $a0, $a0, -0x4800
/* 0FA640 802D5C90 3C03802E */  lui   $v1, 0x802e
/* 0FA644 802D5C94 2463B7D8 */  addiu $v1, $v1, -0x4828
/* 0FA648 802D5C98 3C01802E */  lui   $at, 0x802e
/* 0FA64C 802D5C9C AC22B7D0 */  sw    $v0, -0x4830($at)
.L802D5CA0:
/* 0FA650 802D5CA0 AC600000 */  sw    $zero, ($v1)
/* 0FA654 802D5CA4 AC800000 */  sw    $zero, ($a0)
/* 0FA658 802D5CA8 24840004 */  addiu $a0, $a0, 4
/* 0FA65C 802D5CAC 24A50001 */  addiu $a1, $a1, 1
/* 0FA660 802D5CB0 28A2000A */  slti  $v0, $a1, 0xa
/* 0FA664 802D5CB4 1440FFFA */  bnez  $v0, .L802D5CA0
/* 0FA668 802D5CB8 24630004 */   addiu $v1, $v1, 4
/* 0FA66C 802D5CBC 3C04802E */  lui   $a0, 0x802e
/* 0FA670 802D5CC0 24849D34 */  addiu $a0, $a0, -0x62cc
/* 0FA674 802D5CC4 24050001 */  addiu $a1, $zero, 1
/* 0FA678 802D5CC8 0C0B0CF8 */  jal   func_802C33E0
/* 0FA67C 802D5CCC 0000302D */   daddu $a2, $zero, $zero
/* 0FA680 802D5CD0 8FBF0010 */  lw    $ra, 0x10($sp)
/* 0FA684 802D5CD4 24020002 */  addiu $v0, $zero, 2
/* 0FA688 802D5CD8 03E00008 */  jr    $ra
/* 0FA68C 802D5CDC 27BD0018 */   addiu $sp, $sp, 0x18

/* 0FA690 802D5CE0 27BDFFD8 */  addiu $sp, $sp, -0x28
/* 0FA694 802D5CE4 AFB1001C */  sw    $s1, 0x1c($sp)
/* 0FA698 802D5CE8 0080882D */  daddu $s1, $a0, $zero
/* 0FA69C 802D5CEC AFBF0020 */  sw    $ra, 0x20($sp)
/* 0FA6A0 802D5CF0 AFB00018 */  sw    $s0, 0x18($sp)
/* 0FA6A4 802D5CF4 8E30000C */  lw    $s0, 0xc($s1)
/* 0FA6A8 802D5CF8 8E050000 */  lw    $a1, ($s0)
/* 0FA6AC 802D5CFC 0C0B1EAF */  jal   func_802C7ABC
/* 0FA6B0 802D5D00 26100004 */   addiu $s0, $s0, 4
/* 0FA6B4 802D5D04 0220202D */  daddu $a0, $s1, $zero
/* 0FA6B8 802D5D08 8E050000 */  lw    $a1, ($s0)
/* 0FA6BC 802D5D0C 0C0B1EAF */  jal   func_802C7ABC
/* 0FA6C0 802D5D10 0040802D */   daddu $s0, $v0, $zero
/* 0FA6C4 802D5D14 0200202D */  daddu $a0, $s0, $zero
/* 0FA6C8 802D5D18 2405FFFF */  addiu $a1, $zero, -1
/* 0FA6CC 802D5D1C 24030008 */  addiu $v1, $zero, 8
/* 0FA6D0 802D5D20 0000302D */  daddu $a2, $zero, $zero
/* 0FA6D4 802D5D24 0040382D */  daddu $a3, $v0, $zero
/* 0FA6D8 802D5D28 0C052A46 */  jal   func_8014A918
/* 0FA6DC 802D5D2C AFA30010 */   sw    $v1, 0x10($sp)
/* 0FA6E0 802D5D30 0002102B */  sltu  $v0, $zero, $v0
/* 0FA6E4 802D5D34 8FBF0020 */  lw    $ra, 0x20($sp)
/* 0FA6E8 802D5D38 8FB1001C */  lw    $s1, 0x1c($sp)
/* 0FA6EC 802D5D3C 8FB00018 */  lw    $s0, 0x18($sp)
/* 0FA6F0 802D5D40 00021040 */  sll   $v0, $v0, 1
/* 0FA6F4 802D5D44 03E00008 */  jr    $ra
/* 0FA6F8 802D5D48 27BD0028 */   addiu $sp, $sp, 0x28

/* 0FA6FC 802D5D4C 27BDFFD0 */  addiu $sp, $sp, -0x30
/* 0FA700 802D5D50 AFB1001C */  sw    $s1, 0x1c($sp)
/* 0FA704 802D5D54 0080882D */  daddu $s1, $a0, $zero
/* 0FA708 802D5D58 AFBF0028 */  sw    $ra, 0x28($sp)
/* 0FA70C 802D5D5C AFB30024 */  sw    $s3, 0x24($sp)
/* 0FA710 802D5D60 AFB20020 */  sw    $s2, 0x20($sp)
/* 0FA714 802D5D64 AFB00018 */  sw    $s0, 0x18($sp)
/* 0FA718 802D5D68 8E30000C */  lw    $s0, 0xc($s1)
/* 0FA71C 802D5D6C 8E050000 */  lw    $a1, ($s0)
/* 0FA720 802D5D70 0C0B1EAF */  jal   func_802C7ABC
/* 0FA724 802D5D74 26100004 */   addiu $s0, $s0, 4
/* 0FA728 802D5D78 8E050000 */  lw    $a1, ($s0)
/* 0FA72C 802D5D7C 26100004 */  addiu $s0, $s0, 4
/* 0FA730 802D5D80 0220202D */  daddu $a0, $s1, $zero
/* 0FA734 802D5D84 0C0B1EAF */  jal   func_802C7ABC
/* 0FA738 802D5D88 0040982D */   daddu $s3, $v0, $zero
/* 0FA73C 802D5D8C 8E050000 */  lw    $a1, ($s0)
/* 0FA740 802D5D90 26100004 */  addiu $s0, $s0, 4
/* 0FA744 802D5D94 0220202D */  daddu $a0, $s1, $zero
/* 0FA748 802D5D98 0C0B1EAF */  jal   func_802C7ABC
/* 0FA74C 802D5D9C 0040902D */   daddu $s2, $v0, $zero
/* 0FA750 802D5DA0 0220202D */  daddu $a0, $s1, $zero
/* 0FA754 802D5DA4 8E050000 */  lw    $a1, ($s0)
/* 0FA758 802D5DA8 0C0B1EAF */  jal   func_802C7ABC
/* 0FA75C 802D5DAC 0040802D */   daddu $s0, $v0, $zero
/* 0FA760 802D5DB0 0260202D */  daddu $a0, $s3, $zero
/* 0FA764 802D5DB4 0240282D */  daddu $a1, $s2, $zero
/* 0FA768 802D5DB8 00021400 */  sll   $v0, $v0, 0x10
/* 0FA76C 802D5DBC 00021403 */  sra   $v0, $v0, 0x10
/* 0FA770 802D5DC0 0200302D */  daddu $a2, $s0, $zero
/* 0FA774 802D5DC4 240701F4 */  addiu $a3, $zero, 0x1f4
/* 0FA778 802D5DC8 0C052A46 */  jal   func_8014A918
/* 0FA77C 802D5DCC AFA20010 */   sw    $v0, 0x10($sp)
/* 0FA780 802D5DD0 0002102B */  sltu  $v0, $zero, $v0
/* 0FA784 802D5DD4 8FBF0028 */  lw    $ra, 0x28($sp)
/* 0FA788 802D5DD8 8FB30024 */  lw    $s3, 0x24($sp)
/* 0FA78C 802D5DDC 8FB20020 */  lw    $s2, 0x20($sp)
/* 0FA790 802D5DE0 8FB1001C */  lw    $s1, 0x1c($sp)
/* 0FA794 802D5DE4 8FB00018 */  lw    $s0, 0x18($sp)
/* 0FA798 802D5DE8 00021040 */  sll   $v0, $v0, 1
/* 0FA79C 802D5DEC 03E00008 */  jr    $ra
/* 0FA7A0 802D5DF0 27BD0030 */   addiu $sp, $sp, 0x30

/* 0FA7A4 802D5DF4 27BDFFC8 */  addiu $sp, $sp, -0x38
/* 0FA7A8 802D5DF8 AFB1001C */  sw    $s1, 0x1c($sp)
/* 0FA7AC 802D5DFC 0080882D */  daddu $s1, $a0, $zero
/* 0FA7B0 802D5E00 AFBF0030 */  sw    $ra, 0x30($sp)
/* 0FA7B4 802D5E04 AFB5002C */  sw    $s5, 0x2c($sp)
/* 0FA7B8 802D5E08 AFB40028 */  sw    $s4, 0x28($sp)
/* 0FA7BC 802D5E0C AFB30024 */  sw    $s3, 0x24($sp)
/* 0FA7C0 802D5E10 AFB20020 */  sw    $s2, 0x20($sp)
/* 0FA7C4 802D5E14 AFB00018 */  sw    $s0, 0x18($sp)
/* 0FA7C8 802D5E18 8E30000C */  lw    $s0, 0xc($s1)
/* 0FA7CC 802D5E1C 8E050000 */  lw    $a1, ($s0)
/* 0FA7D0 802D5E20 0C0B1EAF */  jal   func_802C7ABC
/* 0FA7D4 802D5E24 26100004 */   addiu $s0, $s0, 4
/* 0FA7D8 802D5E28 8E050000 */  lw    $a1, ($s0)
/* 0FA7DC 802D5E2C 26100004 */  addiu $s0, $s0, 4
/* 0FA7E0 802D5E30 0220202D */  daddu $a0, $s1, $zero
/* 0FA7E4 802D5E34 0C0B1EAF */  jal   func_802C7ABC
/* 0FA7E8 802D5E38 0040A82D */   daddu $s5, $v0, $zero
/* 0FA7EC 802D5E3C 8E050000 */  lw    $a1, ($s0)
/* 0FA7F0 802D5E40 26100004 */  addiu $s0, $s0, 4
/* 0FA7F4 802D5E44 0220202D */  daddu $a0, $s1, $zero
/* 0FA7F8 802D5E48 0C0B1EAF */  jal   func_802C7ABC
/* 0FA7FC 802D5E4C 0040982D */   daddu $s3, $v0, $zero
/* 0FA800 802D5E50 8E050000 */  lw    $a1, ($s0)
/* 0FA804 802D5E54 26100004 */  addiu $s0, $s0, 4
/* 0FA808 802D5E58 0220202D */  daddu $a0, $s1, $zero
/* 0FA80C 802D5E5C 0C0B1EAF */  jal   func_802C7ABC
/* 0FA810 802D5E60 0040A02D */   daddu $s4, $v0, $zero
/* 0FA814 802D5E64 8E050000 */  lw    $a1, ($s0)
/* 0FA818 802D5E68 26100004 */  addiu $s0, $s0, 4
/* 0FA81C 802D5E6C 0220202D */  daddu $a0, $s1, $zero
/* 0FA820 802D5E70 0C0B1EAF */  jal   func_802C7ABC
/* 0FA824 802D5E74 0040902D */   daddu $s2, $v0, $zero
/* 0FA828 802D5E78 0220202D */  daddu $a0, $s1, $zero
/* 0FA82C 802D5E7C 8E050000 */  lw    $a1, ($s0)
/* 0FA830 802D5E80 0C0B1EAF */  jal   func_802C7ABC
/* 0FA834 802D5E84 0040802D */   daddu $s0, $v0, $zero
/* 0FA838 802D5E88 02A0202D */  daddu $a0, $s5, $zero
/* 0FA83C 802D5E8C 0260282D */  daddu $a1, $s3, $zero
/* 0FA840 802D5E90 00108400 */  sll   $s0, $s0, 0x10
/* 0FA844 802D5E94 00108403 */  sra   $s0, $s0, 0x10
/* 0FA848 802D5E98 00021400 */  sll   $v0, $v0, 0x10
/* 0FA84C 802D5E9C 00021403 */  sra   $v0, $v0, 0x10
/* 0FA850 802D5EA0 0280302D */  daddu $a2, $s4, $zero
/* 0FA854 802D5EA4 0240382D */  daddu $a3, $s2, $zero
/* 0FA858 802D5EA8 AFB00010 */  sw    $s0, 0x10($sp)
/* 0FA85C 802D5EAC 0C052A59 */  jal   func_8014A964
/* 0FA860 802D5EB0 AFA20014 */   sw    $v0, 0x14($sp)
/* 0FA864 802D5EB4 0002102B */  sltu  $v0, $zero, $v0
/* 0FA868 802D5EB8 8FBF0030 */  lw    $ra, 0x30($sp)
/* 0FA86C 802D5EBC 8FB5002C */  lw    $s5, 0x2c($sp)
/* 0FA870 802D5EC0 8FB40028 */  lw    $s4, 0x28($sp)
/* 0FA874 802D5EC4 8FB30024 */  lw    $s3, 0x24($sp)
/* 0FA878 802D5EC8 8FB20020 */  lw    $s2, 0x20($sp)
/* 0FA87C 802D5ECC 8FB1001C */  lw    $s1, 0x1c($sp)
/* 0FA880 802D5ED0 8FB00018 */  lw    $s0, 0x18($sp)
/* 0FA884 802D5ED4 00021040 */  sll   $v0, $v0, 1
/* 0FA888 802D5ED8 03E00008 */  jr    $ra
/* 0FA88C 802D5EDC 27BD0038 */   addiu $sp, $sp, 0x38

/* 0FA890 802D5EE0 27BDFFE8 */  addiu $sp, $sp, -0x18
/* 0FA894 802D5EE4 AFBF0010 */  sw    $ra, 0x10($sp)
/* 0FA898 802D5EE8 8C82000C */  lw    $v0, 0xc($a0)
/* 0FA89C 802D5EEC 0C0B1EAF */  jal   func_802C7ABC
/* 0FA8A0 802D5EF0 8C450000 */   lw    $a1, ($v0)
/* 0FA8A4 802D5EF4 3C048016 */  lui   $a0, 0x8016
/* 0FA8A8 802D5EF8 24849AF0 */  addiu $a0, $a0, -0x6510
/* 0FA8AC 802D5EFC 00021840 */  sll   $v1, $v0, 1
/* 0FA8B0 802D5F00 00621821 */  addu  $v1, $v1, $v0
/* 0FA8B4 802D5F04 00031900 */  sll   $v1, $v1, 4
/* 0FA8B8 802D5F08 00641821 */  addu  $v1, $v1, $a0
/* 0FA8BC 802D5F0C 94640000 */  lhu   $a0, ($v1)
/* 0FA8C0 802D5F10 24020002 */  addiu $v0, $zero, 2
/* 0FA8C4 802D5F14 00822025 */  or    $a0, $a0, $v0
/* 0FA8C8 802D5F18 A4640000 */  sh    $a0, ($v1)
/* 0FA8CC 802D5F1C 8FBF0010 */  lw    $ra, 0x10($sp)
/* 0FA8D0 802D5F20 03E00008 */  jr    $ra
/* 0FA8D4 802D5F24 27BD0018 */   addiu $sp, $sp, 0x18

/* 0FA8D8 802D5F28 27BDFFE0 */  addiu $sp, $sp, -0x20
/* 0FA8DC 802D5F2C AFB10014 */  sw    $s1, 0x14($sp)
/* 0FA8E0 802D5F30 0080882D */  daddu $s1, $a0, $zero
/* 0FA8E4 802D5F34 AFBF001C */  sw    $ra, 0x1c($sp)
/* 0FA8E8 802D5F38 AFB20018 */  sw    $s2, 0x18($sp)
/* 0FA8EC 802D5F3C AFB00010 */  sw    $s0, 0x10($sp)
/* 0FA8F0 802D5F40 8E30000C */  lw    $s0, 0xc($s1)
/* 0FA8F4 802D5F44 8E050000 */  lw    $a1, ($s0)
/* 0FA8F8 802D5F48 0C0B1EAF */  jal   func_802C7ABC
/* 0FA8FC 802D5F4C 26100004 */   addiu $s0, $s0, 4
/* 0FA900 802D5F50 8E050000 */  lw    $a1, ($s0)
/* 0FA904 802D5F54 26100004 */  addiu $s0, $s0, 4
/* 0FA908 802D5F58 0220202D */  daddu $a0, $s1, $zero
/* 0FA90C 802D5F5C 0C0B1EAF */  jal   func_802C7ABC
/* 0FA910 802D5F60 0040902D */   daddu $s2, $v0, $zero
/* 0FA914 802D5F64 0220202D */  daddu $a0, $s1, $zero
/* 0FA918 802D5F68 8E050000 */  lw    $a1, ($s0)
/* 0FA91C 802D5F6C 0C0B1EAF */  jal   func_802C7ABC
/* 0FA920 802D5F70 0040802D */   daddu $s0, $v0, $zero
/* 0FA924 802D5F74 0240202D */  daddu $a0, $s2, $zero
/* 0FA928 802D5F78 0200282D */  daddu $a1, $s0, $zero
/* 0FA92C 802D5F7C 00021400 */  sll   $v0, $v0, 0x10
/* 0FA930 802D5F80 0C052A95 */  jal   func_8014AA54
/* 0FA934 802D5F84 00023403 */   sra   $a2, $v0, 0x10
/* 0FA938 802D5F88 8FBF001C */  lw    $ra, 0x1c($sp)
/* 0FA93C 802D5F8C 8FB20018 */  lw    $s2, 0x18($sp)
/* 0FA940 802D5F90 8FB10014 */  lw    $s1, 0x14($sp)
/* 0FA944 802D5F94 8FB00010 */  lw    $s0, 0x10($sp)
/* 0FA948 802D5F98 24020002 */  addiu $v0, $zero, 2
/* 0FA94C 802D5F9C 03E00008 */  jr    $ra
/* 0FA950 802D5FA0 27BD0020 */   addiu $sp, $sp, 0x20

/* 0FA954 802D5FA4 27BDFFE8 */  addiu $sp, $sp, -0x18
/* 0FA958 802D5FA8 AFBF0010 */  sw    $ra, 0x10($sp)
/* 0FA95C 802D5FAC 8C82000C */  lw    $v0, 0xc($a0)
/* 0FA960 802D5FB0 0C0B1EAF */  jal   func_802C7ABC
/* 0FA964 802D5FB4 8C450000 */   lw    $a1, ($v0)
/* 0FA968 802D5FB8 0000202D */  daddu $a0, $zero, $zero
/* 0FA96C 802D5FBC 00021400 */  sll   $v0, $v0, 0x10
/* 0FA970 802D5FC0 0C052AC3 */  jal   func_8014AB0C
/* 0FA974 802D5FC4 00022C03 */   sra   $a1, $v0, 0x10
/* 0FA978 802D5FC8 8FBF0010 */  lw    $ra, 0x10($sp)
/* 0FA97C 802D5FCC 24020002 */  addiu $v0, $zero, 2
/* 0FA980 802D5FD0 03E00008 */  jr    $ra
/* 0FA984 802D5FD4 27BD0018 */   addiu $sp, $sp, 0x18

/* 0FA988 802D5FD8 27BDFFE8 */  addiu $sp, $sp, -0x18
/* 0FA98C 802D5FDC AFBF0010 */  sw    $ra, 0x10($sp)
/* 0FA990 802D5FE0 0C052B69 */  jal   func_8014ADA4
/* 0FA994 802D5FE4 00000000 */   nop   
/* 0FA998 802D5FE8 8FBF0010 */  lw    $ra, 0x10($sp)
/* 0FA99C 802D5FEC 24020002 */  addiu $v0, $zero, 2
/* 0FA9A0 802D5FF0 03E00008 */  jr    $ra
/* 0FA9A4 802D5FF4 27BD0018 */   addiu $sp, $sp, 0x18

/* 0FA9A8 802D5FF8 27BDFFE0 */  addiu $sp, $sp, -0x20
/* 0FA9AC 802D5FFC AFB10014 */  sw    $s1, 0x14($sp)
/* 0FA9B0 802D6000 0080882D */  daddu $s1, $a0, $zero
/* 0FA9B4 802D6004 AFBF0018 */  sw    $ra, 0x18($sp)
/* 0FA9B8 802D6008 AFB00010 */  sw    $s0, 0x10($sp)
/* 0FA9BC 802D600C 8E30000C */  lw    $s0, 0xc($s1)
/* 0FA9C0 802D6010 8E050000 */  lw    $a1, ($s0)
/* 0FA9C4 802D6014 0C0B1EAF */  jal   func_802C7ABC
/* 0FA9C8 802D6018 26100004 */   addiu $s0, $s0, 4
/* 0FA9CC 802D601C 0220202D */  daddu $a0, $s1, $zero
/* 0FA9D0 802D6020 8E050000 */  lw    $a1, ($s0)
/* 0FA9D4 802D6024 0C0B1EAF */  jal   func_802C7ABC
/* 0FA9D8 802D6028 0040802D */   daddu $s0, $v0, $zero
/* 0FA9DC 802D602C 0200202D */  daddu $a0, $s0, $zero
/* 0FA9E0 802D6030 0C052B7E */  jal   func_8014ADF8
/* 0FA9E4 802D6034 0040282D */   daddu $a1, $v0, $zero
/* 0FA9E8 802D6038 8FBF0018 */  lw    $ra, 0x18($sp)
/* 0FA9EC 802D603C 8FB10014 */  lw    $s1, 0x14($sp)
/* 0FA9F0 802D6040 8FB00010 */  lw    $s0, 0x10($sp)
/* 0FA9F4 802D6044 24020002 */  addiu $v0, $zero, 2
/* 0FA9F8 802D6048 03E00008 */  jr    $ra
/* 0FA9FC 802D604C 27BD0020 */   addiu $sp, $sp, 0x20

/* 0FAA00 802D6050 27BDFFE8 */  addiu $sp, $sp, -0x18
/* 0FAA04 802D6054 AFBF0010 */  sw    $ra, 0x10($sp)
/* 0FAA08 802D6058 0C052B9B */  jal   func_8014AE6C
/* 0FAA0C 802D605C 00000000 */   nop   
/* 0FAA10 802D6060 8FBF0010 */  lw    $ra, 0x10($sp)
/* 0FAA14 802D6064 24020002 */  addiu $v0, $zero, 2
/* 0FAA18 802D6068 03E00008 */  jr    $ra
/* 0FAA1C 802D606C 27BD0018 */   addiu $sp, $sp, 0x18

/* 0FAA20 802D6070 27BDFFE8 */  addiu $sp, $sp, -0x18
/* 0FAA24 802D6074 AFBF0010 */  sw    $ra, 0x10($sp)
/* 0FAA28 802D6078 0C052BBE */  jal   func_8014AEF8
/* 0FAA2C 802D607C 00000000 */   nop   
/* 0FAA30 802D6080 8FBF0010 */  lw    $ra, 0x10($sp)
/* 0FAA34 802D6084 24020002 */  addiu $v0, $zero, 2
/* 0FAA38 802D6088 03E00008 */  jr    $ra
/* 0FAA3C 802D608C 27BD0018 */   addiu $sp, $sp, 0x18

/* 0FAA40 802D6090 27BDFFE0 */  addiu $sp, $sp, -0x20
/* 0FAA44 802D6094 AFB10014 */  sw    $s1, 0x14($sp)
/* 0FAA48 802D6098 0080882D */  daddu $s1, $a0, $zero
/* 0FAA4C 802D609C AFBF0018 */  sw    $ra, 0x18($sp)
/* 0FAA50 802D60A0 AFB00010 */  sw    $s0, 0x10($sp)
/* 0FAA54 802D60A4 8E30000C */  lw    $s0, 0xc($s1)
/* 0FAA58 802D60A8 8E050000 */  lw    $a1, ($s0)
/* 0FAA5C 802D60AC 0C0B1EAF */  jal   func_802C7ABC
/* 0FAA60 802D60B0 26100004 */   addiu $s0, $s0, 4
/* 0FAA64 802D60B4 0220202D */  daddu $a0, $s1, $zero
/* 0FAA68 802D60B8 8E050000 */  lw    $a1, ($s0)
/* 0FAA6C 802D60BC 0C0B1EAF */  jal   func_802C7ABC
/* 0FAA70 802D60C0 0040802D */   daddu $s0, $v0, $zero
/* 0FAA74 802D60C4 0200202D */  daddu $a0, $s0, $zero
/* 0FAA78 802D60C8 0C052BE3 */  jal   func_8014AF8C
/* 0FAA7C 802D60CC 0040282D */   daddu $a1, $v0, $zero
/* 0FAA80 802D60D0 8FBF0018 */  lw    $ra, 0x18($sp)
/* 0FAA84 802D60D4 8FB10014 */  lw    $s1, 0x14($sp)
/* 0FAA88 802D60D8 8FB00010 */  lw    $s0, 0x10($sp)
/* 0FAA8C 802D60DC 24020002 */  addiu $v0, $zero, 2
/* 0FAA90 802D60E0 03E00008 */  jr    $ra
/* 0FAA94 802D60E4 27BD0020 */   addiu $sp, $sp, 0x20

/* 0FAA98 802D60E8 27BDFFE8 */  addiu $sp, $sp, -0x18
/* 0FAA9C 802D60EC AFBF0010 */  sw    $ra, 0x10($sp)
/* 0FAAA0 802D60F0 8C82000C */  lw    $v0, 0xc($a0)
/* 0FAAA4 802D60F4 0C0B1EAF */  jal   func_802C7ABC
/* 0FAAA8 802D60F8 8C450000 */   lw    $a1, ($v0)
/* 0FAAAC 802D60FC 2404FFFF */  addiu $a0, $zero, -1
/* 0FAAB0 802D6100 0C051CDA */  jal   func_80147368
/* 0FAAB4 802D6104 0040282D */   daddu $a1, $v0, $zero
/* 0FAAB8 802D6108 0002102B */  sltu  $v0, $zero, $v0
/* 0FAABC 802D610C 8FBF0010 */  lw    $ra, 0x10($sp)
/* 0FAAC0 802D6110 00021040 */  sll   $v0, $v0, 1
/* 0FAAC4 802D6114 03E00008 */  jr    $ra
/* 0FAAC8 802D6118 27BD0018 */   addiu $sp, $sp, 0x18

/* 0FAACC 802D611C 27BDFFE8 */  addiu $sp, $sp, -0x18
/* 0FAAD0 802D6120 AFBF0010 */  sw    $ra, 0x10($sp)
/* 0FAAD4 802D6124 8C82000C */  lw    $v0, 0xc($a0)
/* 0FAAD8 802D6128 0C0B1EAF */  jal   func_802C7ABC
/* 0FAADC 802D612C 8C450000 */   lw    $a1, ($v0)
/* 0FAAE0 802D6130 0040202D */  daddu $a0, $v0, $zero
/* 0FAAE4 802D6134 0C051CDA */  jal   func_80147368
/* 0FAAE8 802D6138 240500FA */   addiu $a1, $zero, 0xfa
/* 0FAAEC 802D613C 0002102B */  sltu  $v0, $zero, $v0
/* 0FAAF0 802D6140 8FBF0010 */  lw    $ra, 0x10($sp)
/* 0FAAF4 802D6144 00021040 */  sll   $v0, $v0, 1
/* 0FAAF8 802D6148 03E00008 */  jr    $ra
/* 0FAAFC 802D614C 27BD0018 */   addiu $sp, $sp, 0x18

/* 0FAB00 802D6150 27BDFFE8 */  addiu $sp, $sp, -0x18
/* 0FAB04 802D6154 AFBF0010 */  sw    $ra, 0x10($sp)
/* 0FAB08 802D6158 8C82000C */  lw    $v0, 0xc($a0)
/* 0FAB0C 802D615C 0C0B1EAF */  jal   func_802C7ABC
/* 0FAB10 802D6160 8C450000 */   lw    $a1, ($v0)
/* 0FAB14 802D6164 0C05272D */  jal   func_80149CB4
/* 0FAB18 802D6168 0040202D */   daddu $a0, $v0, $zero
/* 0FAB1C 802D616C 8FBF0010 */  lw    $ra, 0x10($sp)
/* 0FAB20 802D6170 24020002 */  addiu $v0, $zero, 2
/* 0FAB24 802D6174 03E00008 */  jr    $ra
/* 0FAB28 802D6178 27BD0018 */   addiu $sp, $sp, 0x18

/* 0FAB2C 802D617C 27BDFFE0 */  addiu $sp, $sp, -0x20
/* 0FAB30 802D6180 AFB10014 */  sw    $s1, 0x14($sp)
/* 0FAB34 802D6184 0080882D */  daddu $s1, $a0, $zero
/* 0FAB38 802D6188 AFBF0018 */  sw    $ra, 0x18($sp)
/* 0FAB3C 802D618C AFB00010 */  sw    $s0, 0x10($sp)
/* 0FAB40 802D6190 8E30000C */  lw    $s0, 0xc($s1)
/* 0FAB44 802D6194 8E050000 */  lw    $a1, ($s0)
/* 0FAB48 802D6198 0C0B1EAF */  jal   func_802C7ABC
/* 0FAB4C 802D619C 26100004 */   addiu $s0, $s0, 4
/* 0FAB50 802D61A0 0220202D */  daddu $a0, $s1, $zero
/* 0FAB54 802D61A4 8E050000 */  lw    $a1, ($s0)
/* 0FAB58 802D61A8 0C0B1EAF */  jal   func_802C7ABC
/* 0FAB5C 802D61AC 0040802D */   daddu $s0, $v0, $zero
/* 0FAB60 802D61B0 0200202D */  daddu $a0, $s0, $zero
/* 0FAB64 802D61B4 304500FF */  andi  $a1, $v0, 0xff
/* 0FAB68 802D61B8 0000302D */  daddu $a2, $zero, $zero
/* 0FAB6C 802D61BC 0C0526AE */  jal   func_80149AB8
/* 0FAB70 802D61C0 00C0382D */   daddu $a3, $a2, $zero
/* 0FAB74 802D61C4 8FBF0018 */  lw    $ra, 0x18($sp)
/* 0FAB78 802D61C8 8FB10014 */  lw    $s1, 0x14($sp)
/* 0FAB7C 802D61CC 8FB00010 */  lw    $s0, 0x10($sp)
/* 0FAB80 802D61D0 24020002 */  addiu $v0, $zero, 2
/* 0FAB84 802D61D4 03E00008 */  jr    $ra
/* 0FAB88 802D61D8 27BD0020 */   addiu $sp, $sp, 0x20

/* 0FAB8C 802D61DC 27BDFFD0 */  addiu $sp, $sp, -0x30
/* 0FAB90 802D61E0 AFB1001C */  sw    $s1, 0x1c($sp)
/* 0FAB94 802D61E4 0080882D */  daddu $s1, $a0, $zero
/* 0FAB98 802D61E8 AFBF002C */  sw    $ra, 0x2c($sp)
/* 0FAB9C 802D61EC AFB40028 */  sw    $s4, 0x28($sp)
/* 0FABA0 802D61F0 AFB30024 */  sw    $s3, 0x24($sp)
/* 0FABA4 802D61F4 AFB20020 */  sw    $s2, 0x20($sp)
/* 0FABA8 802D61F8 AFB00018 */  sw    $s0, 0x18($sp)
/* 0FABAC 802D61FC 8E30000C */  lw    $s0, 0xc($s1)
/* 0FABB0 802D6200 8E050000 */  lw    $a1, ($s0)
/* 0FABB4 802D6204 0C0B1EAF */  jal   func_802C7ABC
/* 0FABB8 802D6208 26100004 */   addiu $s0, $s0, 4
/* 0FABBC 802D620C 8E050000 */  lw    $a1, ($s0)
/* 0FABC0 802D6210 26100004 */  addiu $s0, $s0, 4
/* 0FABC4 802D6214 0220202D */  daddu $a0, $s1, $zero
/* 0FABC8 802D6218 0C0B1EAF */  jal   func_802C7ABC
/* 0FABCC 802D621C 0040A02D */   daddu $s4, $v0, $zero
/* 0FABD0 802D6220 8E050000 */  lw    $a1, ($s0)
/* 0FABD4 802D6224 26100004 */  addiu $s0, $s0, 4
/* 0FABD8 802D6228 0220202D */  daddu $a0, $s1, $zero
/* 0FABDC 802D622C 0C0B1EAF */  jal   func_802C7ABC
/* 0FABE0 802D6230 0040982D */   daddu $s3, $v0, $zero
/* 0FABE4 802D6234 8E050000 */  lw    $a1, ($s0)
/* 0FABE8 802D6238 26100004 */  addiu $s0, $s0, 4
/* 0FABEC 802D623C 0220202D */  daddu $a0, $s1, $zero
/* 0FABF0 802D6240 0C0B1EAF */  jal   func_802C7ABC
/* 0FABF4 802D6244 0040902D */   daddu $s2, $v0, $zero
/* 0FABF8 802D6248 0220202D */  daddu $a0, $s1, $zero
/* 0FABFC 802D624C 8E050000 */  lw    $a1, ($s0)
/* 0FAC00 802D6250 0C0B1EAF */  jal   func_802C7ABC
/* 0FAC04 802D6254 0040802D */   daddu $s0, $v0, $zero
/* 0FAC08 802D6258 0280202D */  daddu $a0, $s4, $zero
/* 0FAC0C 802D625C 0260282D */  daddu $a1, $s3, $zero
/* 0FAC10 802D6260 44921000 */  mtc1  $s2, $f2
/* 0FAC14 802D6264 00000000 */  nop   
/* 0FAC18 802D6268 468010A0 */  cvt.s.w $f2, $f2
/* 0FAC1C 802D626C 44061000 */  mfc1  $a2, $f2
/* 0FAC20 802D6270 44901000 */  mtc1  $s0, $f2
/* 0FAC24 802D6274 00000000 */  nop   
/* 0FAC28 802D6278 468010A0 */  cvt.s.w $f2, $f2
/* 0FAC2C 802D627C 44071000 */  mfc1  $a3, $f2
/* 0FAC30 802D6280 44820000 */  mtc1  $v0, $f0
/* 0FAC34 802D6284 00000000 */  nop   
/* 0FAC38 802D6288 46800020 */  cvt.s.w $f0, $f0
/* 0FAC3C 802D628C 0C052757 */  jal   func_80149D5C
/* 0FAC40 802D6290 E7A00010 */   swc1  $f0, 0x10($sp)
/* 0FAC44 802D6294 8FBF002C */  lw    $ra, 0x2c($sp)
/* 0FAC48 802D6298 8FB40028 */  lw    $s4, 0x28($sp)
/* 0FAC4C 802D629C 8FB30024 */  lw    $s3, 0x24($sp)
/* 0FAC50 802D62A0 8FB20020 */  lw    $s2, 0x20($sp)
/* 0FAC54 802D62A4 8FB1001C */  lw    $s1, 0x1c($sp)
/* 0FAC58 802D62A8 8FB00018 */  lw    $s0, 0x18($sp)
/* 0FAC5C 802D62AC 24020002 */  addiu $v0, $zero, 2
/* 0FAC60 802D62B0 03E00008 */  jr    $ra
/* 0FAC64 802D62B4 27BD0030 */   addiu $sp, $sp, 0x30

/* 0FAC68 802D62B8 27BDFFE8 */  addiu $sp, $sp, -0x18
/* 0FAC6C 802D62BC AFBF0010 */  sw    $ra, 0x10($sp)
/* 0FAC70 802D62C0 8C82000C */  lw    $v0, 0xc($a0)
/* 0FAC74 802D62C4 0C0B1EAF */  jal   func_802C7ABC
/* 0FAC78 802D62C8 8C450000 */   lw    $a1, ($v0)
/* 0FAC7C 802D62CC 0C05271B */  jal   func_80149C6C
/* 0FAC80 802D62D0 0040202D */   daddu $a0, $v0, $zero
/* 0FAC84 802D62D4 8FBF0010 */  lw    $ra, 0x10($sp)
/* 0FAC88 802D62D8 24020002 */  addiu $v0, $zero, 2
/* 0FAC8C 802D62DC 03E00008 */  jr    $ra
/* 0FAC90 802D62E0 27BD0018 */   addiu $sp, $sp, 0x18

/* 0FAC94 802D62E4 27BDFFE8 */  addiu $sp, $sp, -0x18
/* 0FAC98 802D62E8 AFBF0010 */  sw    $ra, 0x10($sp)
/* 0FAC9C 802D62EC 8C82000C */  lw    $v0, 0xc($a0)
/* 0FACA0 802D62F0 0C0B1EAF */  jal   func_802C7ABC
/* 0FACA4 802D62F4 8C450000 */   lw    $a1, ($v0)
/* 0FACA8 802D62F8 0040202D */  daddu $a0, $v0, $zero
/* 0FACAC 802D62FC 0C05269B */  jal   func_80149A6C
/* 0FACB0 802D6300 24050001 */   addiu $a1, $zero, 1
/* 0FACB4 802D6304 8FBF0010 */  lw    $ra, 0x10($sp)
/* 0FACB8 802D6308 24020002 */  addiu $v0, $zero, 2
/* 0FACBC 802D630C 03E00008 */  jr    $ra
/* 0FACC0 802D6310 27BD0018 */   addiu $sp, $sp, 0x18

/* 0FACC4 802D6314 27BDFFE8 */  addiu $sp, $sp, -0x18
/* 0FACC8 802D6318 AFBF0010 */  sw    $ra, 0x10($sp)
/* 0FACCC 802D631C 8C82000C */  lw    $v0, 0xc($a0)
/* 0FACD0 802D6320 0C0B1EAF */  jal   func_802C7ABC
/* 0FACD4 802D6324 8C450000 */   lw    $a1, ($v0)
/* 0FACD8 802D6328 8FBF0010 */  lw    $ra, 0x10($sp)
/* 0FACDC 802D632C 3C018015 */  lui   $at, 0x8015
/* 0FACE0 802D6330 A4221340 */  sh    $v0, 0x1340($at)
/* 0FACE4 802D6334 24020002 */  addiu $v0, $zero, 2
/* 0FACE8 802D6338 03E00008 */  jr    $ra
/* 0FACEC 802D633C 27BD0018 */   addiu $sp, $sp, 0x18

/* 0FACF0 802D6340 27BDFFE8 */  addiu $sp, $sp, -0x18
/* 0FACF4 802D6344 AFBF0010 */  sw    $ra, 0x10($sp)
/* 0FACF8 802D6348 8C82000C */  lw    $v0, 0xc($a0)
/* 0FACFC 802D634C 0C0B1EAF */  jal   func_802C7ABC
/* 0FAD00 802D6350 8C450000 */   lw    $a1, ($v0)
/* 0FAD04 802D6354 8FBF0010 */  lw    $ra, 0x10($sp)
/* 0FAD08 802D6358 3C018015 */  lui   $at, 0x8015
/* 0FAD0C 802D635C A4221308 */  sh    $v0, 0x1308($at)
/* 0FAD10 802D6360 24020002 */  addiu $v0, $zero, 2
/* 0FAD14 802D6364 03E00008 */  jr    $ra
/* 0FAD18 802D6368 27BD0018 */   addiu $sp, $sp, 0x18

/* 0FAD1C 802D636C 27BDFFC0 */  addiu $sp, $sp, -0x40
/* 0FAD20 802D6370 AFB1001C */  sw    $s1, 0x1c($sp)
/* 0FAD24 802D6374 0080882D */  daddu $s1, $a0, $zero
/* 0FAD28 802D6378 AFBF0028 */  sw    $ra, 0x28($sp)
/* 0FAD2C 802D637C AFB30024 */  sw    $s3, 0x24($sp)
/* 0FAD30 802D6380 AFB20020 */  sw    $s2, 0x20($sp)
/* 0FAD34 802D6384 AFB00018 */  sw    $s0, 0x18($sp)
/* 0FAD38 802D6388 F7B60038 */  sdc1  $f22, 0x38($sp)
/* 0FAD3C 802D638C F7B40030 */  sdc1  $f20, 0x30($sp)
/* 0FAD40 802D6390 8E30000C */  lw    $s0, 0xc($s1)
/* 0FAD44 802D6394 8E130000 */  lw    $s3, ($s0)
/* 0FAD48 802D6398 26100004 */  addiu $s0, $s0, 4
/* 0FAD4C 802D639C 8E050000 */  lw    $a1, ($s0)
/* 0FAD50 802D63A0 0C0B1EAF */  jal   func_802C7ABC
/* 0FAD54 802D63A4 26100004 */   addiu $s0, $s0, 4
/* 0FAD58 802D63A8 8E050000 */  lw    $a1, ($s0)
/* 0FAD5C 802D63AC 26100004 */  addiu $s0, $s0, 4
/* 0FAD60 802D63B0 0220202D */  daddu $a0, $s1, $zero
/* 0FAD64 802D63B4 0C0B210B */  jal   func_802C842C
/* 0FAD68 802D63B8 0040902D */   daddu $s2, $v0, $zero
/* 0FAD6C 802D63BC 8E050000 */  lw    $a1, ($s0)
/* 0FAD70 802D63C0 26100004 */  addiu $s0, $s0, 4
/* 0FAD74 802D63C4 0220202D */  daddu $a0, $s1, $zero
/* 0FAD78 802D63C8 0C0B210B */  jal   func_802C842C
/* 0FAD7C 802D63CC 46000586 */   mov.s $f22, $f0
/* 0FAD80 802D63D0 0220202D */  daddu $a0, $s1, $zero
/* 0FAD84 802D63D4 8E050000 */  lw    $a1, ($s0)
/* 0FAD88 802D63D8 0C0B210B */  jal   func_802C842C
/* 0FAD8C 802D63DC 46000506 */   mov.s $f20, $f0
/* 0FAD90 802D63E0 0260202D */  daddu $a0, $s3, $zero
/* 0FAD94 802D63E4 4406B000 */  mfc1  $a2, $f22
/* 0FAD98 802D63E8 4407A000 */  mfc1  $a3, $f20
/* 0FAD9C 802D63EC 3245FFFF */  andi  $a1, $s2, 0xffff
/* 0FADA0 802D63F0 0C052757 */  jal   func_80149D5C
/* 0FADA4 802D63F4 E7A00010 */   swc1  $f0, 0x10($sp)
/* 0FADA8 802D63F8 8FBF0028 */  lw    $ra, 0x28($sp)
/* 0FADAC 802D63FC 8FB30024 */  lw    $s3, 0x24($sp)
/* 0FADB0 802D6400 8FB20020 */  lw    $s2, 0x20($sp)
/* 0FADB4 802D6404 8FB1001C */  lw    $s1, 0x1c($sp)
/* 0FADB8 802D6408 8FB00018 */  lw    $s0, 0x18($sp)
/* 0FADBC 802D640C D7B60038 */  ldc1  $f22, 0x38($sp)
/* 0FADC0 802D6410 D7B40030 */  ldc1  $f20, 0x30($sp)
/* 0FADC4 802D6414 24020002 */  addiu $v0, $zero, 2
/* 0FADC8 802D6418 03E00008 */  jr    $ra
/* 0FADCC 802D641C 27BD0040 */   addiu $sp, $sp, 0x40

/* 0FADD0 802D6420 27BDFFD8 */  addiu $sp, $sp, -0x28
/* 0FADD4 802D6424 AFB00010 */  sw    $s0, 0x10($sp)
/* 0FADD8 802D6428 0080802D */  daddu $s0, $a0, $zero
/* 0FADDC 802D642C AFB3001C */  sw    $s3, 0x1c($sp)
/* 0FADE0 802D6430 3C138011 */  lui   $s3, 0x8011
/* 0FADE4 802D6434 2673F290 */  addiu $s3, $s3, -0xd70
/* 0FADE8 802D6438 AFB10014 */  sw    $s1, 0x14($sp)
/* 0FADEC 802D643C 3C11802E */  lui   $s1, 0x802e
/* 0FADF0 802D6440 2631B830 */  addiu $s1, $s1, -0x47d0
/* 0FADF4 802D6444 AFBF0020 */  sw    $ra, 0x20($sp)
/* 0FADF8 802D6448 AFB20018 */  sw    $s2, 0x18($sp)
/* 0FADFC 802D644C 8E12014C */  lw    $s2, 0x14c($s0)
/* 0FAE00 802D6450 54A00001 */  bnezl $a1, .L802D6458
/* 0FAE04 802D6454 AE000070 */   sw    $zero, 0x70($s0)
.L802D6458:
/* 0FAE08 802D6458 8E030070 */  lw    $v1, 0x70($s0)
/* 0FAE0C 802D645C 10600005 */  beqz  $v1, .L802D6474
/* 0FAE10 802D6460 24020001 */   addiu $v0, $zero, 1
/* 0FAE14 802D6464 1062004B */  beq   $v1, $v0, .L802D6594
/* 0FAE18 802D6468 0000102D */   daddu $v0, $zero, $zero
/* 0FAE1C 802D646C 080B5988 */  j     func_802D6620
/* 0FAE20 802D6470 00000000 */   nop   

.L802D6474:
/* 0FAE24 802D6474 0C03805E */  jal   func_800E0178
/* 0FAE28 802D6478 00000000 */   nop   
/* 0FAE2C 802D647C 0C038045 */  jal   func_800E0114
/* 0FAE30 802D6480 00000000 */   nop   
/* 0FAE34 802D6484 0C03BD8A */  jal   func_800EF628
/* 0FAE38 802D6488 00000000 */   nop   
/* 0FAE3C 802D648C 0C03A5EE */  jal   func_800E97B8
/* 0FAE40 802D6490 00000000 */   nop   
/* 0FAE44 802D6494 0000482D */  daddu $t1, $zero, $zero
/* 0FAE48 802D6498 0120402D */  daddu $t0, $t1, $zero
/* 0FAE4C 802D649C 3C0C8008 */  lui   $t4, 0x8008
/* 0FAE50 802D64A0 258C78E0 */  addiu $t4, $t4, 0x78e0
/* 0FAE54 802D64A4 3C0B8009 */  lui   $t3, 0x8009
/* 0FAE58 802D64A8 256BA680 */  addiu $t3, $t3, -0x5980
/* 0FAE5C 802D64AC 240A0001 */  addiu $t2, $zero, 1
/* 0FAE60 802D64B0 0260382D */  daddu $a3, $s3, $zero
/* 0FAE64 802D64B4 3C03800A */  lui   $v1, 0x800a
/* 0FAE68 802D64B8 2463A650 */  addiu $v1, $v1, -0x59b0
/* 0FAE6C 802D64BC 8C620000 */  lw    $v0, ($v1)
/* 0FAE70 802D64C0 0220302D */  daddu $a2, $s1, $zero
/* 0FAE74 802D64C4 34420040 */  ori   $v0, $v0, 0x40
/* 0FAE78 802D64C8 AC620000 */  sw    $v0, ($v1)
.L802D64CC:
/* 0FAE7C 802D64CC 84E40074 */  lh    $a0, 0x74($a3)
/* 0FAE80 802D64D0 5080001F */  beql  $a0, $zero, .L802D6550
/* 0FAE84 802D64D4 25080001 */   addiu $t0, $t0, 1
/* 0FAE88 802D64D8 8E430028 */  lw    $v1, 0x28($s2)
/* 0FAE8C 802D64DC 8C620000 */  lw    $v0, ($v1)
/* 0FAE90 802D64E0 18400008 */  blez  $v0, .L802D6504
/* 0FAE94 802D64E4 0000282D */   daddu $a1, $zero, $zero
.L802D64E8:
/* 0FAE98 802D64E8 54820003 */  bnel  $a0, $v0, .L802D64F8
/* 0FAE9C 802D64EC 24630004 */   addiu $v1, $v1, 4
/* 0FAEA0 802D64F0 080B5941 */  j     func_802D6504
/* 0FAEA4 802D64F4 24050001 */   addiu $a1, $zero, 1

.L802D64F8:
/* 0FAEA8 802D64F8 8C620000 */  lw    $v0, ($v1)
/* 0FAEAC 802D64FC 1C40FFFA */  bgtz  $v0, .L802D64E8
/* 0FAEB0 802D6500 00000000 */   nop   
func_802D6504:
.L802D6504:
/* 0FAEB4 802D6504 50A00012 */  beql  $a1, $zero, .L802D6550
/* 0FAEB8 802D6508 25080001 */   addiu $t0, $t0, 1
/* 0FAEBC 802D650C 84E30074 */  lh    $v1, 0x74($a3)
/* 0FAEC0 802D6510 00031940 */  sll   $v1, $v1, 5
/* 0FAEC4 802D6514 006C1821 */  addu  $v1, $v1, $t4
/* 0FAEC8 802D6518 84620004 */  lh    $v0, 4($v1)
/* 0FAECC 802D651C 000210C0 */  sll   $v0, $v0, 3
/* 0FAED0 802D6520 004B1021 */  addu  $v0, $v0, $t3
/* 0FAED4 802D6524 8C420000 */  lw    $v0, ($v0)
/* 0FAED8 802D6528 ACC80108 */  sw    $t0, 0x108($a2)
/* 0FAEDC 802D652C ACCA018C */  sw    $t2, 0x18c($a2)
/* 0FAEE0 802D6530 ACC20000 */  sw    $v0, ($a2)
/* 0FAEE4 802D6534 8C620000 */  lw    $v0, ($v1)
/* 0FAEE8 802D6538 ACC20084 */  sw    $v0, 0x84($a2)
/* 0FAEEC 802D653C 8C620014 */  lw    $v0, 0x14($v1)
/* 0FAEF0 802D6540 25290001 */  addiu $t1, $t1, 1
/* 0FAEF4 802D6544 ACC20294 */  sw    $v0, 0x294($a2)
/* 0FAEF8 802D6548 24C60004 */  addiu $a2, $a2, 4
/* 0FAEFC 802D654C 25080001 */  addiu $t0, $t0, 1
.L802D6550:
/* 0FAF00 802D6550 29020020 */  slti  $v0, $t0, 0x20
/* 0FAF04 802D6554 1440FFDD */  bnez  $v0, .L802D64CC
/* 0FAF08 802D6558 24E70002 */   addiu $a3, $a3, 2
/* 0FAF0C 802D655C 15200004 */  bnez  $t1, .L802D6570
/* 0FAF10 802D6560 2402000C */   addiu $v0, $zero, 0xc
/* 0FAF14 802D6564 AE000084 */  sw    $zero, 0x84($s0)
/* 0FAF18 802D6568 080B5988 */  j     func_802D6620
/* 0FAF1C 802D656C 24020001 */   addiu $v0, $zero, 1

.L802D6570:
/* 0FAF20 802D6570 0220202D */  daddu $a0, $s1, $zero
/* 0FAF24 802D6574 AE220318 */  sw    $v0, 0x318($s1)
/* 0FAF28 802D6578 AE290324 */  sw    $t1, 0x324($s1)
/* 0FAF2C 802D657C 0C03D390 */  jal   func_800F4E40
/* 0FAF30 802D6580 AE200328 */   sw    $zero, 0x328($s1)
/* 0FAF34 802D6584 24020001 */  addiu $v0, $zero, 1
/* 0FAF38 802D6588 AE000074 */  sw    $zero, 0x74($s0)
/* 0FAF3C 802D658C 080B5987 */  j     func_802D661C
/* 0FAF40 802D6590 AE020070 */   sw    $v0, 0x70($s0)

.L802D6594:
/* 0FAF44 802D6594 8E020074 */  lw    $v0, 0x74($s0)
/* 0FAF48 802D6598 14400008 */  bnez  $v0, .L802D65BC
/* 0FAF4C 802D659C 24420001 */   addiu $v0, $v0, 1
/* 0FAF50 802D65A0 8622032C */  lh    $v0, 0x32c($s1)
/* 0FAF54 802D65A4 1040001D */  beqz  $v0, .L802D661C
/* 0FAF58 802D65A8 AE020078 */   sw    $v0, 0x78($s0)
/* 0FAF5C 802D65AC 0C03C4EC */  jal   func_800F13B0
/* 0FAF60 802D65B0 00000000 */   nop   
/* 0FAF64 802D65B4 8E020074 */  lw    $v0, 0x74($s0)
/* 0FAF68 802D65B8 24420001 */  addiu $v0, $v0, 1
.L802D65BC:
/* 0FAF6C 802D65BC AE020074 */  sw    $v0, 0x74($s0)
/* 0FAF70 802D65C0 2842000F */  slti  $v0, $v0, 0xf
/* 0FAF74 802D65C4 14400016 */  bnez  $v0, .L802D6620
/* 0FAF78 802D65C8 0000102D */   daddu $v0, $zero, $zero
/* 0FAF7C 802D65CC 0C03C54E */  jal   func_800F1538
/* 0FAF80 802D65D0 00000000 */   nop   
/* 0FAF84 802D65D4 8E030078 */  lw    $v1, 0x78($s0)
/* 0FAF88 802D65D8 240200FF */  addiu $v0, $zero, 0xff
/* 0FAF8C 802D65DC 54620005 */  bnel  $v1, $v0, .L802D65F4
/* 0FAF90 802D65E0 2462FFFF */   addiu $v0, $v1, -1
/* 0FAF94 802D65E4 2402FFFF */  addiu $v0, $zero, -1
/* 0FAF98 802D65E8 AE020084 */  sw    $v0, 0x84($s0)
/* 0FAF9C 802D65EC 080B5988 */  j     func_802D6620
/* 0FAFA0 802D65F0 24020001 */   addiu $v0, $zero, 1

.L802D65F4:
/* 0FAFA4 802D65F4 00021080 */  sll   $v0, $v0, 2
/* 0FAFA8 802D65F8 00511021 */  addu  $v0, $v0, $s1
/* 0FAFAC 802D65FC 8C430108 */  lw    $v1, 0x108($v0)
/* 0FAFB0 802D6600 00031040 */  sll   $v0, $v1, 1
/* 0FAFB4 802D6604 00531021 */  addu  $v0, $v0, $s3
/* 0FAFB8 802D6608 AE030088 */  sw    $v1, 0x88($s0)
/* 0FAFBC 802D660C 84430074 */  lh    $v1, 0x74($v0)
/* 0FAFC0 802D6610 24020001 */  addiu $v0, $zero, 1
/* 0FAFC4 802D6614 080B5988 */  j     func_802D6620
/* 0FAFC8 802D6618 AE030084 */   sw    $v1, 0x84($s0)

func_802D661C:
.L802D661C:
/* 0FAFCC 802D661C 0000102D */  daddu $v0, $zero, $zero
func_802D6620:
.L802D6620:
/* 0FAFD0 802D6620 8FBF0020 */  lw    $ra, 0x20($sp)
/* 0FAFD4 802D6624 8FB3001C */  lw    $s3, 0x1c($sp)
/* 0FAFD8 802D6628 8FB20018 */  lw    $s2, 0x18($sp)
/* 0FAFDC 802D662C 8FB10014 */  lw    $s1, 0x14($sp)
/* 0FAFE0 802D6630 8FB00010 */  lw    $s0, 0x10($sp)
/* 0FAFE4 802D6634 03E00008 */  jr    $ra
/* 0FAFE8 802D6638 27BD0028 */   addiu $sp, $sp, 0x28

/* 0FAFEC 802D663C 27BDFFD8 */  addiu $sp, $sp, -0x28
/* 0FAFF0 802D6640 AFB00010 */  sw    $s0, 0x10($sp)
/* 0FAFF4 802D6644 0080802D */  daddu $s0, $a0, $zero
/* 0FAFF8 802D6648 AFB3001C */  sw    $s3, 0x1c($sp)
/* 0FAFFC 802D664C 3C138011 */  lui   $s3, 0x8011
/* 0FB000 802D6650 2673F290 */  addiu $s3, $s3, -0xd70
/* 0FB004 802D6654 AFB10014 */  sw    $s1, 0x14($sp)
/* 0FB008 802D6658 3C11802E */  lui   $s1, 0x802e
/* 0FB00C 802D665C 2631B830 */  addiu $s1, $s1, -0x47d0
/* 0FB010 802D6660 AFBF0020 */  sw    $ra, 0x20($sp)
/* 0FB014 802D6664 AFB20018 */  sw    $s2, 0x18($sp)
/* 0FB018 802D6668 8E12014C */  lw    $s2, 0x14c($s0)
/* 0FB01C 802D666C 54A00001 */  bnezl $a1, .L802D6674
/* 0FB020 802D6670 AE000070 */   sw    $zero, 0x70($s0)
.L802D6674:
/* 0FB024 802D6674 8E030070 */  lw    $v1, 0x70($s0)
/* 0FB028 802D6678 10600005 */  beqz  $v1, .L802D6690
/* 0FB02C 802D667C 24020001 */   addiu $v0, $zero, 1
/* 0FB030 802D6680 1062004B */  beq   $v1, $v0, .L802D67B0
/* 0FB034 802D6684 0000102D */   daddu $v0, $zero, $zero
/* 0FB038 802D6688 080B5A0F */  j     func_802D683C
/* 0FB03C 802D668C 00000000 */   nop   

.L802D6690:
/* 0FB040 802D6690 0C03805E */  jal   func_800E0178
/* 0FB044 802D6694 00000000 */   nop   
/* 0FB048 802D6698 0C038045 */  jal   func_800E0114
/* 0FB04C 802D669C 00000000 */   nop   
/* 0FB050 802D66A0 0C03BD8A */  jal   func_800EF628
/* 0FB054 802D66A4 00000000 */   nop   
/* 0FB058 802D66A8 0C03A5EE */  jal   func_800E97B8
/* 0FB05C 802D66AC 00000000 */   nop   
/* 0FB060 802D66B0 0000482D */  daddu $t1, $zero, $zero
/* 0FB064 802D66B4 0120402D */  daddu $t0, $t1, $zero
/* 0FB068 802D66B8 3C0C8008 */  lui   $t4, 0x8008
/* 0FB06C 802D66BC 258C78E0 */  addiu $t4, $t4, 0x78e0
/* 0FB070 802D66C0 3C0B8009 */  lui   $t3, 0x8009
/* 0FB074 802D66C4 256BA680 */  addiu $t3, $t3, -0x5980
/* 0FB078 802D66C8 240A0001 */  addiu $t2, $zero, 1
/* 0FB07C 802D66CC 0260382D */  daddu $a3, $s3, $zero
/* 0FB080 802D66D0 3C03800A */  lui   $v1, 0x800a
/* 0FB084 802D66D4 2463A650 */  addiu $v1, $v1, -0x59b0
/* 0FB088 802D66D8 8C620000 */  lw    $v0, ($v1)
/* 0FB08C 802D66DC 0220302D */  daddu $a2, $s1, $zero
/* 0FB090 802D66E0 34420040 */  ori   $v0, $v0, 0x40
/* 0FB094 802D66E4 AC620000 */  sw    $v0, ($v1)
.L802D66E8:
/* 0FB098 802D66E8 84E401B4 */  lh    $a0, 0x1b4($a3)
/* 0FB09C 802D66EC 5080001F */  beql  $a0, $zero, .L802D676C
/* 0FB0A0 802D66F0 25080001 */   addiu $t0, $t0, 1
/* 0FB0A4 802D66F4 8E430028 */  lw    $v1, 0x28($s2)
/* 0FB0A8 802D66F8 8C620000 */  lw    $v0, ($v1)
/* 0FB0AC 802D66FC 18400008 */  blez  $v0, .L802D6720
/* 0FB0B0 802D6700 0000282D */   daddu $a1, $zero, $zero
.L802D6704:
/* 0FB0B4 802D6704 54820003 */  bnel  $a0, $v0, .L802D6714
/* 0FB0B8 802D6708 24630004 */   addiu $v1, $v1, 4
/* 0FB0BC 802D670C 080B59C8 */  j     func_802D6720
/* 0FB0C0 802D6710 24050001 */   addiu $a1, $zero, 1

.L802D6714:
/* 0FB0C4 802D6714 8C620000 */  lw    $v0, ($v1)
/* 0FB0C8 802D6718 1C40FFFA */  bgtz  $v0, .L802D6704
/* 0FB0CC 802D671C 00000000 */   nop   
func_802D6720:
.L802D6720:
/* 0FB0D0 802D6720 50A00012 */  beql  $a1, $zero, .L802D676C
/* 0FB0D4 802D6724 25080001 */   addiu $t0, $t0, 1
/* 0FB0D8 802D6728 84E301B4 */  lh    $v1, 0x1b4($a3)
/* 0FB0DC 802D672C 00031940 */  sll   $v1, $v1, 5
/* 0FB0E0 802D6730 006C1821 */  addu  $v1, $v1, $t4
/* 0FB0E4 802D6734 84620004 */  lh    $v0, 4($v1)
/* 0FB0E8 802D6738 000210C0 */  sll   $v0, $v0, 3
/* 0FB0EC 802D673C 004B1021 */  addu  $v0, $v0, $t3
/* 0FB0F0 802D6740 8C420000 */  lw    $v0, ($v0)
/* 0FB0F4 802D6744 ACC80108 */  sw    $t0, 0x108($a2)
/* 0FB0F8 802D6748 ACCA018C */  sw    $t2, 0x18c($a2)
/* 0FB0FC 802D674C ACC20000 */  sw    $v0, ($a2)
/* 0FB100 802D6750 8C620000 */  lw    $v0, ($v1)
/* 0FB104 802D6754 ACC20084 */  sw    $v0, 0x84($a2)
/* 0FB108 802D6758 8C620014 */  lw    $v0, 0x14($v1)
/* 0FB10C 802D675C 25290001 */  addiu $t1, $t1, 1
/* 0FB110 802D6760 ACC20294 */  sw    $v0, 0x294($a2)
/* 0FB114 802D6764 24C60004 */  addiu $a2, $a2, 4
/* 0FB118 802D6768 25080001 */  addiu $t0, $t0, 1
.L802D676C:
/* 0FB11C 802D676C 2902000A */  slti  $v0, $t0, 0xa
/* 0FB120 802D6770 1440FFDD */  bnez  $v0, .L802D66E8
/* 0FB124 802D6774 24E70002 */   addiu $a3, $a3, 2
/* 0FB128 802D6778 15200004 */  bnez  $t1, .L802D678C
/* 0FB12C 802D677C 2402000C */   addiu $v0, $zero, 0xc
/* 0FB130 802D6780 AE000084 */  sw    $zero, 0x84($s0)
/* 0FB134 802D6784 080B5A0F */  j     func_802D683C
/* 0FB138 802D6788 24020001 */   addiu $v0, $zero, 1

.L802D678C:
/* 0FB13C 802D678C 0220202D */  daddu $a0, $s1, $zero
/* 0FB140 802D6790 AE220318 */  sw    $v0, 0x318($s1)
/* 0FB144 802D6794 AE290324 */  sw    $t1, 0x324($s1)
/* 0FB148 802D6798 0C03D390 */  jal   func_800F4E40
/* 0FB14C 802D679C AE200328 */   sw    $zero, 0x328($s1)
/* 0FB150 802D67A0 24020001 */  addiu $v0, $zero, 1
/* 0FB154 802D67A4 AE000074 */  sw    $zero, 0x74($s0)
/* 0FB158 802D67A8 080B5A0E */  j     func_802D6838
/* 0FB15C 802D67AC AE020070 */   sw    $v0, 0x70($s0)

.L802D67B0:
/* 0FB160 802D67B0 8E020074 */  lw    $v0, 0x74($s0)
/* 0FB164 802D67B4 14400008 */  bnez  $v0, .L802D67D8
/* 0FB168 802D67B8 24420001 */   addiu $v0, $v0, 1
/* 0FB16C 802D67BC 8622032C */  lh    $v0, 0x32c($s1)
/* 0FB170 802D67C0 1040001D */  beqz  $v0, .L802D6838
/* 0FB174 802D67C4 AE020078 */   sw    $v0, 0x78($s0)
/* 0FB178 802D67C8 0C03C4EC */  jal   func_800F13B0
/* 0FB17C 802D67CC 00000000 */   nop   
/* 0FB180 802D67D0 8E020074 */  lw    $v0, 0x74($s0)
/* 0FB184 802D67D4 24420001 */  addiu $v0, $v0, 1
.L802D67D8:
/* 0FB188 802D67D8 AE020074 */  sw    $v0, 0x74($s0)
/* 0FB18C 802D67DC 2842000F */  slti  $v0, $v0, 0xf
/* 0FB190 802D67E0 14400016 */  bnez  $v0, .L802D683C
/* 0FB194 802D67E4 0000102D */   daddu $v0, $zero, $zero
/* 0FB198 802D67E8 0C03C54E */  jal   func_800F1538
/* 0FB19C 802D67EC 00000000 */   nop   
/* 0FB1A0 802D67F0 8E030078 */  lw    $v1, 0x78($s0)
/* 0FB1A4 802D67F4 240200FF */  addiu $v0, $zero, 0xff
/* 0FB1A8 802D67F8 54620005 */  bnel  $v1, $v0, .L802D6810
/* 0FB1AC 802D67FC 2462FFFF */   addiu $v0, $v1, -1
/* 0FB1B0 802D6800 2402FFFF */  addiu $v0, $zero, -1
/* 0FB1B4 802D6804 AE020084 */  sw    $v0, 0x84($s0)
/* 0FB1B8 802D6808 080B5A0F */  j     func_802D683C
/* 0FB1BC 802D680C 24020001 */   addiu $v0, $zero, 1

.L802D6810:
/* 0FB1C0 802D6810 00021080 */  sll   $v0, $v0, 2
/* 0FB1C4 802D6814 00511021 */  addu  $v0, $v0, $s1
/* 0FB1C8 802D6818 8C430108 */  lw    $v1, 0x108($v0)
/* 0FB1CC 802D681C 00031040 */  sll   $v0, $v1, 1
/* 0FB1D0 802D6820 00531021 */  addu  $v0, $v0, $s3
/* 0FB1D4 802D6824 AE030088 */  sw    $v1, 0x88($s0)
/* 0FB1D8 802D6828 844301B4 */  lh    $v1, 0x1b4($v0)
/* 0FB1DC 802D682C 24020001 */  addiu $v0, $zero, 1
/* 0FB1E0 802D6830 080B5A0F */  j     func_802D683C
/* 0FB1E4 802D6834 AE030084 */   sw    $v1, 0x84($s0)

func_802D6838:
.L802D6838:
/* 0FB1E8 802D6838 0000102D */  daddu $v0, $zero, $zero
func_802D683C:
.L802D683C:
/* 0FB1EC 802D683C 8FBF0020 */  lw    $ra, 0x20($sp)
/* 0FB1F0 802D6840 8FB3001C */  lw    $s3, 0x1c($sp)
/* 0FB1F4 802D6844 8FB20018 */  lw    $s2, 0x18($sp)
/* 0FB1F8 802D6848 8FB10014 */  lw    $s1, 0x14($sp)
/* 0FB1FC 802D684C 8FB00010 */  lw    $s0, 0x10($sp)
/* 0FB200 802D6850 03E00008 */  jr    $ra
/* 0FB204 802D6854 27BD0028 */   addiu $sp, $sp, 0x28

/* 0FB208 802D6858 27BDFFE8 */  addiu $sp, $sp, -0x18
/* 0FB20C 802D685C AFBF0010 */  sw    $ra, 0x10($sp)
/* 0FB210 802D6860 8C82000C */  lw    $v0, 0xc($a0)
/* 0FB214 802D6864 0C0B1EAF */  jal   func_802C7ABC
/* 0FB218 802D6868 8C450000 */   lw    $a1, ($v0)
/* 0FB21C 802D686C 00021840 */  sll   $v1, $v0, 1
/* 0FB220 802D6870 3C018011 */  lui   $at, 0x8011
/* 0FB224 802D6874 00230821 */  addu  $at, $at, $v1
/* 0FB228 802D6878 A420F304 */  sh    $zero, -0xcfc($at)
/* 0FB22C 802D687C 8FBF0010 */  lw    $ra, 0x10($sp)
/* 0FB230 802D6880 24020002 */  addiu $v0, $zero, 2
/* 0FB234 802D6884 03E00008 */  jr    $ra
/* 0FB238 802D6888 27BD0018 */   addiu $sp, $sp, 0x18

/* 0FB23C 802D688C 27BDFFE8 */  addiu $sp, $sp, -0x18
/* 0FB240 802D6890 AFBF0010 */  sw    $ra, 0x10($sp)
/* 0FB244 802D6894 8C82000C */  lw    $v0, 0xc($a0)
/* 0FB248 802D6898 0C0B1EAF */  jal   func_802C7ABC
/* 0FB24C 802D689C 8C450000 */   lw    $a1, ($v0)
/* 0FB250 802D68A0 00021040 */  sll   $v0, $v0, 1
/* 0FB254 802D68A4 3C018011 */  lui   $at, 0x8011
/* 0FB258 802D68A8 00220821 */  addu  $at, $at, $v0
/* 0FB25C 802D68AC A420F444 */  sh    $zero, -0xbbc($at)
/* 0FB260 802D68B0 0C039DB3 */  jal   func_800E76CC
/* 0FB264 802D68B4 00000000 */   nop   
/* 0FB268 802D68B8 8FBF0010 */  lw    $ra, 0x10($sp)
/* 0FB26C 802D68BC 24020002 */  addiu $v0, $zero, 2
/* 0FB270 802D68C0 03E00008 */  jr    $ra
/* 0FB274 802D68C4 27BD0018 */   addiu $sp, $sp, 0x18

/* 0FB278 802D68C8 27BDFFE8 */  addiu $sp, $sp, -0x18
/* 0FB27C 802D68CC AFBF0014 */  sw    $ra, 0x14($sp)
/* 0FB280 802D68D0 AFB00010 */  sw    $s0, 0x10($sp)
/* 0FB284 802D68D4 8C82000C */  lw    $v0, 0xc($a0)
/* 0FB288 802D68D8 0C0B1EAF */  jal   func_802C7ABC
/* 0FB28C 802D68DC 8C450000 */   lw    $a1, ($v0)
/* 0FB290 802D68E0 3C108011 */  lui   $s0, 0x8011
/* 0FB294 802D68E4 2610F290 */  addiu $s0, $s0, -0xd70
/* 0FB298 802D68E8 0040282D */  daddu $a1, $v0, $zero
/* 0FB29C 802D68EC 24020010 */  addiu $v0, $zero, 0x10
/* 0FB2A0 802D68F0 14A20006 */  bne   $a1, $v0, .L802D690C
/* 0FB2A4 802D68F4 0000182D */   daddu $v1, $zero, $zero
/* 0FB2A8 802D68F8 9203000E */  lbu   $v1, 0xe($s0)
/* 0FB2AC 802D68FC 24020002 */  addiu $v0, $zero, 2
/* 0FB2B0 802D6900 24630001 */  addiu $v1, $v1, 1
/* 0FB2B4 802D6904 080B5A51 */  j     func_802D6944
/* 0FB2B8 802D6908 A203000E */   sb    $v1, 0xe($s0)

.L802D690C:
/* 0FB2BC 802D690C 0200202D */  daddu $a0, $s0, $zero
.L802D6910:
/* 0FB2C0 802D6910 84820074 */  lh    $v0, 0x74($a0)
/* 0FB2C4 802D6914 10400006 */  beqz  $v0, .L802D6930
/* 0FB2C8 802D6918 28620020 */   slti  $v0, $v1, 0x20
/* 0FB2CC 802D691C 24630001 */  addiu $v1, $v1, 1
/* 0FB2D0 802D6920 28620020 */  slti  $v0, $v1, 0x20
/* 0FB2D4 802D6924 1440FFFA */  bnez  $v0, .L802D6910
/* 0FB2D8 802D6928 24840002 */   addiu $a0, $a0, 2
/* 0FB2DC 802D692C 28620020 */  slti  $v0, $v1, 0x20
.L802D6930:
/* 0FB2E0 802D6930 10400003 */  beqz  $v0, .L802D6940
/* 0FB2E4 802D6934 00031040 */   sll   $v0, $v1, 1
/* 0FB2E8 802D6938 02021021 */  addu  $v0, $s0, $v0
/* 0FB2EC 802D693C A4450074 */  sh    $a1, 0x74($v0)
.L802D6940:
/* 0FB2F0 802D6940 24020002 */  addiu $v0, $zero, 2
func_802D6944:
/* 0FB2F4 802D6944 8FBF0014 */  lw    $ra, 0x14($sp)
/* 0FB2F8 802D6948 8FB00010 */  lw    $s0, 0x10($sp)
/* 0FB2FC 802D694C 03E00008 */  jr    $ra
/* 0FB300 802D6950 27BD0018 */   addiu $sp, $sp, 0x18

/* 0FB304 802D6954 27BDFFE8 */  addiu $sp, $sp, -0x18
/* 0FB308 802D6958 AFBF0010 */  sw    $ra, 0x10($sp)
/* 0FB30C 802D695C 0C038069 */  jal   func_800E01A4
/* 0FB310 802D6960 00000000 */   nop   
/* 0FB314 802D6964 0C038050 */  jal   func_800E0140
/* 0FB318 802D6968 00000000 */   nop   
/* 0FB31C 802D696C 0C03BD80 */  jal   func_800EF600
/* 0FB320 802D6970 00000000 */   nop   
/* 0FB324 802D6974 3C03800A */  lui   $v1, 0x800a
/* 0FB328 802D6978 2463A650 */  addiu $v1, $v1, -0x59b0
/* 0FB32C 802D697C 8C640000 */  lw    $a0, ($v1)
/* 0FB330 802D6980 2405FFBF */  addiu $a1, $zero, -0x41
/* 0FB334 802D6984 00852024 */  and   $a0, $a0, $a1
/* 0FB338 802D6988 AC640000 */  sw    $a0, ($v1)
/* 0FB33C 802D698C 8FBF0010 */  lw    $ra, 0x10($sp)
/* 0FB340 802D6990 24020002 */  addiu $v0, $zero, 2
/* 0FB344 802D6994 03E00008 */  jr    $ra
/* 0FB348 802D6998 27BD0018 */   addiu $sp, $sp, 0x18

/* 0FB34C 802D699C 27BDFFE0 */  addiu $sp, $sp, -0x20
/* 0FB350 802D69A0 AFB10014 */  sw    $s1, 0x14($sp)
/* 0FB354 802D69A4 0080882D */  daddu $s1, $a0, $zero
/* 0FB358 802D69A8 AFBF0018 */  sw    $ra, 0x18($sp)
/* 0FB35C 802D69AC AFB00010 */  sw    $s0, 0x10($sp)
/* 0FB360 802D69B0 8E30000C */  lw    $s0, 0xc($s1)
/* 0FB364 802D69B4 8E050000 */  lw    $a1, ($s0)
/* 0FB368 802D69B8 0C0B1EAF */  jal   func_802C7ABC
/* 0FB36C 802D69BC 26100004 */   addiu $s0, $s0, 4
/* 0FB370 802D69C0 0040202D */  daddu $a0, $v0, $zero
/* 0FB374 802D69C4 0000302D */  daddu $a2, $zero, $zero
/* 0FB378 802D69C8 3C038011 */  lui   $v1, 0x8011
/* 0FB37C 802D69CC 2463F290 */  addiu $v1, $v1, -0xd70
/* 0FB380 802D69D0 8E050000 */  lw    $a1, ($s0)
.L802D69D4:
/* 0FB384 802D69D4 84620074 */  lh    $v0, 0x74($v1)
/* 0FB388 802D69D8 50440006 */  beql  $v0, $a0, .L802D69F4
/* 0FB38C 802D69DC 0220202D */   daddu $a0, $s1, $zero
/* 0FB390 802D69E0 24C60001 */  addiu $a2, $a2, 1
/* 0FB394 802D69E4 28C20020 */  slti  $v0, $a2, 0x20
/* 0FB398 802D69E8 1440FFFA */  bnez  $v0, .L802D69D4
/* 0FB39C 802D69EC 24630002 */   addiu $v1, $v1, 2
/* 0FB3A0 802D69F0 0220202D */  daddu $a0, $s1, $zero
.L802D69F4:
/* 0FB3A4 802D69F4 0C0B2026 */  jal   func_802C8098
/* 0FB3A8 802D69F8 28C60020 */   slti  $a2, $a2, 0x20
/* 0FB3AC 802D69FC 8FBF0018 */  lw    $ra, 0x18($sp)
/* 0FB3B0 802D6A00 8FB10014 */  lw    $s1, 0x14($sp)
/* 0FB3B4 802D6A04 8FB00010 */  lw    $s0, 0x10($sp)
/* 0FB3B8 802D6A08 24020002 */  addiu $v0, $zero, 2
/* 0FB3BC 802D6A0C 03E00008 */  jr    $ra
/* 0FB3C0 802D6A10 27BD0020 */   addiu $sp, $sp, 0x20

/* 0FB3C4 802D6A14 27BDFFE0 */  addiu $sp, $sp, -0x20
/* 0FB3C8 802D6A18 AFB10014 */  sw    $s1, 0x14($sp)
/* 0FB3CC 802D6A1C 0080882D */  daddu $s1, $a0, $zero
/* 0FB3D0 802D6A20 AFBF0018 */  sw    $ra, 0x18($sp)
/* 0FB3D4 802D6A24 AFB00010 */  sw    $s0, 0x10($sp)
/* 0FB3D8 802D6A28 8E30000C */  lw    $s0, 0xc($s1)
/* 0FB3DC 802D6A2C 8E050000 */  lw    $a1, ($s0)
/* 0FB3E0 802D6A30 0C0B1EAF */  jal   func_802C7ABC
/* 0FB3E4 802D6A34 26100004 */   addiu $s0, $s0, 4
/* 0FB3E8 802D6A38 0040302D */  daddu $a2, $v0, $zero
/* 0FB3EC 802D6A3C 0000182D */  daddu $v1, $zero, $zero
/* 0FB3F0 802D6A40 3C048011 */  lui   $a0, 0x8011
/* 0FB3F4 802D6A44 2484F290 */  addiu $a0, $a0, -0xd70
/* 0FB3F8 802D6A48 8E050000 */  lw    $a1, ($s0)
.L802D6A4C:
/* 0FB3FC 802D6A4C 84820074 */  lh    $v0, 0x74($a0)
/* 0FB400 802D6A50 10460006 */  beq   $v0, $a2, .L802D6A6C
/* 0FB404 802D6A54 24020020 */   addiu $v0, $zero, 0x20
/* 0FB408 802D6A58 24630001 */  addiu $v1, $v1, 1
/* 0FB40C 802D6A5C 28620020 */  slti  $v0, $v1, 0x20
/* 0FB410 802D6A60 1440FFFA */  bnez  $v0, .L802D6A4C
/* 0FB414 802D6A64 24840002 */   addiu $a0, $a0, 2
/* 0FB418 802D6A68 24020020 */  addiu $v0, $zero, 0x20
.L802D6A6C:
/* 0FB41C 802D6A6C 10620002 */  beq   $v1, $v0, .L802D6A78
/* 0FB420 802D6A70 2406FFFF */   addiu $a2, $zero, -1
/* 0FB424 802D6A74 0060302D */  daddu $a2, $v1, $zero
.L802D6A78:
/* 0FB428 802D6A78 0C0B2026 */  jal   func_802C8098
/* 0FB42C 802D6A7C 0220202D */   daddu $a0, $s1, $zero
/* 0FB430 802D6A80 8FBF0018 */  lw    $ra, 0x18($sp)
/* 0FB434 802D6A84 8FB10014 */  lw    $s1, 0x14($sp)
/* 0FB438 802D6A88 8FB00010 */  lw    $s0, 0x10($sp)
/* 0FB43C 802D6A8C 24020002 */  addiu $v0, $zero, 2
/* 0FB440 802D6A90 03E00008 */  jr    $ra
/* 0FB444 802D6A94 27BD0020 */   addiu $sp, $sp, 0x20

/* 0FB448 802D6A98 27BDFFE0 */  addiu $sp, $sp, -0x20
/* 0FB44C 802D6A9C AFB10014 */  sw    $s1, 0x14($sp)
/* 0FB450 802D6AA0 0080882D */  daddu $s1, $a0, $zero
/* 0FB454 802D6AA4 AFBF0018 */  sw    $ra, 0x18($sp)
/* 0FB458 802D6AA8 AFB00010 */  sw    $s0, 0x10($sp)
/* 0FB45C 802D6AAC 8E30000C */  lw    $s0, 0xc($s1)
/* 0FB460 802D6AB0 8E050000 */  lw    $a1, ($s0)
/* 0FB464 802D6AB4 0C0B1EAF */  jal   func_802C7ABC
/* 0FB468 802D6AB8 26100004 */   addiu $s0, $s0, 4
/* 0FB46C 802D6ABC 8E100000 */  lw    $s0, ($s0)
/* 0FB470 802D6AC0 0C039D5D */  jal   func_800E7574
/* 0FB474 802D6AC4 0040202D */   daddu $a0, $v0, $zero
/* 0FB478 802D6AC8 0220202D */  daddu $a0, $s1, $zero
/* 0FB47C 802D6ACC 0040302D */  daddu $a2, $v0, $zero
/* 0FB480 802D6AD0 0C0B2026 */  jal   func_802C8098
/* 0FB484 802D6AD4 0200282D */   daddu $a1, $s0, $zero
/* 0FB488 802D6AD8 8FBF0018 */  lw    $ra, 0x18($sp)
/* 0FB48C 802D6ADC 8FB10014 */  lw    $s1, 0x14($sp)
/* 0FB490 802D6AE0 8FB00010 */  lw    $s0, 0x10($sp)
/* 0FB494 802D6AE4 24020002 */  addiu $v0, $zero, 2
/* 0FB498 802D6AE8 03E00008 */  jr    $ra
/* 0FB49C 802D6AEC 27BD0020 */   addiu $sp, $sp, 0x20

/* 0FB4A0 802D6AF0 27BDFFE8 */  addiu $sp, $sp, -0x18
/* 0FB4A4 802D6AF4 AFBF0010 */  sw    $ra, 0x10($sp)
/* 0FB4A8 802D6AF8 8C82000C */  lw    $v0, 0xc($a0)
/* 0FB4AC 802D6AFC 8C450000 */  lw    $a1, ($v0)
/* 0FB4B0 802D6B00 0C0B2026 */  jal   func_802C8098
/* 0FB4B4 802D6B04 0000302D */   daddu $a2, $zero, $zero
/* 0FB4B8 802D6B08 8FBF0010 */  lw    $ra, 0x10($sp)
/* 0FB4BC 802D6B0C 24020002 */  addiu $v0, $zero, 2
/* 0FB4C0 802D6B10 03E00008 */  jr    $ra
/* 0FB4C4 802D6B14 27BD0018 */   addiu $sp, $sp, 0x18

/* 0FB4C8 802D6B18 27BDFFE0 */  addiu $sp, $sp, -0x20
/* 0FB4CC 802D6B1C AFB10014 */  sw    $s1, 0x14($sp)
/* 0FB4D0 802D6B20 0080882D */  daddu $s1, $a0, $zero
/* 0FB4D4 802D6B24 AFBF0018 */  sw    $ra, 0x18($sp)
/* 0FB4D8 802D6B28 AFB00010 */  sw    $s0, 0x10($sp)
/* 0FB4DC 802D6B2C 8E30000C */  lw    $s0, 0xc($s1)
/* 0FB4E0 802D6B30 8E050000 */  lw    $a1, ($s0)
/* 0FB4E4 802D6B34 0C0B1EAF */  jal   func_802C7ABC
/* 0FB4E8 802D6B38 26100004 */   addiu $s0, $s0, 4
/* 0FB4EC 802D6B3C 0040302D */  daddu $a2, $v0, $zero
/* 0FB4F0 802D6B40 0000182D */  daddu $v1, $zero, $zero
/* 0FB4F4 802D6B44 3C048011 */  lui   $a0, 0x8011
/* 0FB4F8 802D6B48 2484F290 */  addiu $a0, $a0, -0xd70
/* 0FB4FC 802D6B4C 8E050000 */  lw    $a1, ($s0)
.L802D6B50:
/* 0FB500 802D6B50 848201B4 */  lh    $v0, 0x1b4($a0)
/* 0FB504 802D6B54 10460006 */  beq   $v0, $a2, .L802D6B70
/* 0FB508 802D6B58 2402000A */   addiu $v0, $zero, 0xa
/* 0FB50C 802D6B5C 24630001 */  addiu $v1, $v1, 1
/* 0FB510 802D6B60 2862000A */  slti  $v0, $v1, 0xa
/* 0FB514 802D6B64 1440FFFA */  bnez  $v0, .L802D6B50
/* 0FB518 802D6B68 24840002 */   addiu $a0, $a0, 2
/* 0FB51C 802D6B6C 2402000A */  addiu $v0, $zero, 0xa
.L802D6B70:
/* 0FB520 802D6B70 10620002 */  beq   $v1, $v0, .L802D6B7C
/* 0FB524 802D6B74 2406FFFF */   addiu $a2, $zero, -1
/* 0FB528 802D6B78 0060302D */  daddu $a2, $v1, $zero
.L802D6B7C:
/* 0FB52C 802D6B7C 0C0B2026 */  jal   func_802C8098
/* 0FB530 802D6B80 0220202D */   daddu $a0, $s1, $zero
/* 0FB534 802D6B84 8FBF0018 */  lw    $ra, 0x18($sp)
/* 0FB538 802D6B88 8FB10014 */  lw    $s1, 0x14($sp)
/* 0FB53C 802D6B8C 8FB00010 */  lw    $s0, 0x10($sp)
/* 0FB540 802D6B90 24020002 */  addiu $v0, $zero, 2
/* 0FB544 802D6B94 03E00008 */  jr    $ra
/* 0FB548 802D6B98 27BD0020 */   addiu $sp, $sp, 0x20

/* 0FB54C 802D6B9C 27BDFFE0 */  addiu $sp, $sp, -0x20
/* 0FB550 802D6BA0 AFB10014 */  sw    $s1, 0x14($sp)
/* 0FB554 802D6BA4 0080882D */  daddu $s1, $a0, $zero
/* 0FB558 802D6BA8 AFBF001C */  sw    $ra, 0x1c($sp)
/* 0FB55C 802D6BAC AFB20018 */  sw    $s2, 0x18($sp)
/* 0FB560 802D6BB0 AFB00010 */  sw    $s0, 0x10($sp)
/* 0FB564 802D6BB4 8E30000C */  lw    $s0, 0xc($s1)
/* 0FB568 802D6BB8 8E050000 */  lw    $a1, ($s0)
/* 0FB56C 802D6BBC 0C0B1EAF */  jal   func_802C7ABC
/* 0FB570 802D6BC0 26100004 */   addiu $s0, $s0, 4
/* 0FB574 802D6BC4 0040282D */  daddu $a1, $v0, $zero
/* 0FB578 802D6BC8 0000182D */  daddu $v1, $zero, $zero
/* 0FB57C 802D6BCC 3C068011 */  lui   $a2, 0x8011
/* 0FB580 802D6BD0 24C6F290 */  addiu $a2, $a2, -0xd70
/* 0FB584 802D6BD4 00C0202D */  daddu $a0, $a2, $zero
/* 0FB588 802D6BD8 8E120000 */  lw    $s2, ($s0)
.L802D6BDC:
/* 0FB58C 802D6BDC 848201B4 */  lh    $v0, 0x1b4($a0)
/* 0FB590 802D6BE0 10450006 */  beq   $v0, $a1, .L802D6BFC
/* 0FB594 802D6BE4 2402000A */   addiu $v0, $zero, 0xa
/* 0FB598 802D6BE8 24630001 */  addiu $v1, $v1, 1
/* 0FB59C 802D6BEC 2862000A */  slti  $v0, $v1, 0xa
/* 0FB5A0 802D6BF0 1440FFFA */  bnez  $v0, .L802D6BDC
/* 0FB5A4 802D6BF4 24840002 */   addiu $a0, $a0, 2
/* 0FB5A8 802D6BF8 2402000A */  addiu $v0, $zero, 0xa
.L802D6BFC:
/* 0FB5AC 802D6BFC 10620002 */  beq   $v1, $v0, .L802D6C08
/* 0FB5B0 802D6C00 2410FFFF */   addiu $s0, $zero, -1
/* 0FB5B4 802D6C04 0060802D */  daddu $s0, $v1, $zero
.L802D6C08:
/* 0FB5B8 802D6C08 06000003 */  bltz  $s0, .L802D6C18
/* 0FB5BC 802D6C0C 00031040 */   sll   $v0, $v1, 1
/* 0FB5C0 802D6C10 00461021 */  addu  $v0, $v0, $a2
/* 0FB5C4 802D6C14 A44001B4 */  sh    $zero, 0x1b4($v0)
.L802D6C18:
/* 0FB5C8 802D6C18 0C039DB3 */  jal   func_800E76CC
/* 0FB5CC 802D6C1C 00000000 */   nop   
/* 0FB5D0 802D6C20 0220202D */  daddu $a0, $s1, $zero
/* 0FB5D4 802D6C24 0240282D */  daddu $a1, $s2, $zero
/* 0FB5D8 802D6C28 0C0B2026 */  jal   func_802C8098
/* 0FB5DC 802D6C2C 0200302D */   daddu $a2, $s0, $zero
/* 0FB5E0 802D6C30 8FBF001C */  lw    $ra, 0x1c($sp)
/* 0FB5E4 802D6C34 8FB20018 */  lw    $s2, 0x18($sp)
/* 0FB5E8 802D6C38 8FB10014 */  lw    $s1, 0x14($sp)
/* 0FB5EC 802D6C3C 8FB00010 */  lw    $s0, 0x10($sp)
/* 0FB5F0 802D6C40 24020002 */  addiu $v0, $zero, 2
/* 0FB5F4 802D6C44 03E00008 */  jr    $ra
/* 0FB5F8 802D6C48 27BD0020 */   addiu $sp, $sp, 0x20

/* 0FB5FC 802D6C4C 27BDFFE0 */  addiu $sp, $sp, -0x20
/* 0FB600 802D6C50 AFB00010 */  sw    $s0, 0x10($sp)
/* 0FB604 802D6C54 0080802D */  daddu $s0, $a0, $zero
/* 0FB608 802D6C58 AFBF0018 */  sw    $ra, 0x18($sp)
/* 0FB60C 802D6C5C AFB10014 */  sw    $s1, 0x14($sp)
/* 0FB610 802D6C60 8E02000C */  lw    $v0, 0xc($s0)
/* 0FB614 802D6C64 0C03A8F9 */  jal   func_800EA3E4
/* 0FB618 802D6C68 8C510000 */   lw    $s1, ($v0)
/* 0FB61C 802D6C6C 0200202D */  daddu $a0, $s0, $zero
/* 0FB620 802D6C70 0040302D */  daddu $a2, $v0, $zero
/* 0FB624 802D6C74 0C0B2026 */  jal   func_802C8098
/* 0FB628 802D6C78 0220282D */   daddu $a1, $s1, $zero
/* 0FB62C 802D6C7C 8FBF0018 */  lw    $ra, 0x18($sp)
/* 0FB630 802D6C80 8FB10014 */  lw    $s1, 0x14($sp)
/* 0FB634 802D6C84 8FB00010 */  lw    $s0, 0x10($sp)
/* 0FB638 802D6C88 24020002 */  addiu $v0, $zero, 2
/* 0FB63C 802D6C8C 03E00008 */  jr    $ra
/* 0FB640 802D6C90 27BD0020 */   addiu $sp, $sp, 0x20

/* 0FB644 802D6C94 27BDFFE8 */  addiu $sp, $sp, -0x18
/* 0FB648 802D6C98 AFBF0010 */  sw    $ra, 0x10($sp)
/* 0FB64C 802D6C9C 8C82000C */  lw    $v0, 0xc($a0)
/* 0FB650 802D6CA0 0C0B1EAF */  jal   func_802C7ABC
/* 0FB654 802D6CA4 8C450000 */   lw    $a1, ($v0)
/* 0FB658 802D6CA8 0C03A8EE */  jal   func_800EA3B8
/* 0FB65C 802D6CAC 0040202D */   daddu $a0, $v0, $zero
/* 0FB660 802D6CB0 8FBF0010 */  lw    $ra, 0x10($sp)
/* 0FB664 802D6CB4 24020002 */  addiu $v0, $zero, 2
/* 0FB668 802D6CB8 03E00008 */  jr    $ra
/* 0FB66C 802D6CBC 27BD0018 */   addiu $sp, $sp, 0x18

/* 0FB670 802D6CC0 27BDFFC8 */  addiu $sp, $sp, -0x38
/* 0FB674 802D6CC4 AFB1001C */  sw    $s1, 0x1c($sp)
/* 0FB678 802D6CC8 0080882D */  daddu $s1, $a0, $zero
/* 0FB67C 802D6CCC AFBF0030 */  sw    $ra, 0x30($sp)
/* 0FB680 802D6CD0 AFB5002C */  sw    $s5, 0x2c($sp)
/* 0FB684 802D6CD4 AFB40028 */  sw    $s4, 0x28($sp)
/* 0FB688 802D6CD8 AFB30024 */  sw    $s3, 0x24($sp)
/* 0FB68C 802D6CDC AFB20020 */  sw    $s2, 0x20($sp)
/* 0FB690 802D6CE0 AFB00018 */  sw    $s0, 0x18($sp)
/* 0FB694 802D6CE4 8E30000C */  lw    $s0, 0xc($s1)
/* 0FB698 802D6CE8 8E050000 */  lw    $a1, ($s0)
/* 0FB69C 802D6CEC 0C0B1EAF */  jal   func_802C7ABC
/* 0FB6A0 802D6CF0 26100004 */   addiu $s0, $s0, 4
/* 0FB6A4 802D6CF4 8E050000 */  lw    $a1, ($s0)
/* 0FB6A8 802D6CF8 26100004 */  addiu $s0, $s0, 4
/* 0FB6AC 802D6CFC 0220202D */  daddu $a0, $s1, $zero
/* 0FB6B0 802D6D00 0C0B1EAF */  jal   func_802C7ABC
/* 0FB6B4 802D6D04 0040A82D */   daddu $s5, $v0, $zero
/* 0FB6B8 802D6D08 8E050000 */  lw    $a1, ($s0)
/* 0FB6BC 802D6D0C 26100004 */  addiu $s0, $s0, 4
/* 0FB6C0 802D6D10 0220202D */  daddu $a0, $s1, $zero
/* 0FB6C4 802D6D14 0C0B1EAF */  jal   func_802C7ABC
/* 0FB6C8 802D6D18 0040A02D */   daddu $s4, $v0, $zero
/* 0FB6CC 802D6D1C 8E050000 */  lw    $a1, ($s0)
/* 0FB6D0 802D6D20 26100004 */  addiu $s0, $s0, 4
/* 0FB6D4 802D6D24 0220202D */  daddu $a0, $s1, $zero
/* 0FB6D8 802D6D28 0C0B1EAF */  jal   func_802C7ABC
/* 0FB6DC 802D6D2C 0040982D */   daddu $s3, $v0, $zero
/* 0FB6E0 802D6D30 8E050000 */  lw    $a1, ($s0)
/* 0FB6E4 802D6D34 26100004 */  addiu $s0, $s0, 4
/* 0FB6E8 802D6D38 0220202D */  daddu $a0, $s1, $zero
/* 0FB6EC 802D6D3C 0C0B1EAF */  jal   func_802C7ABC
/* 0FB6F0 802D6D40 0040902D */   daddu $s2, $v0, $zero
/* 0FB6F4 802D6D44 0220202D */  daddu $a0, $s1, $zero
/* 0FB6F8 802D6D48 8E050000 */  lw    $a1, ($s0)
/* 0FB6FC 802D6D4C 0C0B1F6A */  jal   func_802C7DA8
/* 0FB700 802D6D50 0040802D */   daddu $s0, $v0, $zero
/* 0FB704 802D6D54 44940000 */  mtc1  $s4, $f0
/* 0FB708 802D6D58 00000000 */  nop   
/* 0FB70C 802D6D5C 46800020 */  cvt.s.w $f0, $f0
/* 0FB710 802D6D60 44050000 */  mfc1  $a1, $f0
/* 0FB714 802D6D64 44930000 */  mtc1  $s3, $f0
/* 0FB718 802D6D68 00000000 */  nop   
/* 0FB71C 802D6D6C 46800020 */  cvt.s.w $f0, $f0
/* 0FB720 802D6D70 44060000 */  mfc1  $a2, $f0
/* 0FB724 802D6D74 44920000 */  mtc1  $s2, $f0
/* 0FB728 802D6D78 00000000 */  nop   
/* 0FB72C 802D6D7C 46800020 */  cvt.s.w $f0, $f0
/* 0FB730 802D6D80 44070000 */  mfc1  $a3, $f0
/* 0FB734 802D6D84 02A0202D */  daddu $a0, $s5, $zero
/* 0FB738 802D6D88 AFB00010 */  sw    $s0, 0x10($sp)
/* 0FB73C 802D6D8C 0C04C6A5 */  jal   func_80131A94
/* 0FB740 802D6D90 AFA20014 */   sw    $v0, 0x14($sp)
/* 0FB744 802D6D94 AE220084 */  sw    $v0, 0x84($s1)
/* 0FB748 802D6D98 8FBF0030 */  lw    $ra, 0x30($sp)
/* 0FB74C 802D6D9C 8FB5002C */  lw    $s5, 0x2c($sp)
/* 0FB750 802D6DA0 8FB40028 */  lw    $s4, 0x28($sp)
/* 0FB754 802D6DA4 8FB30024 */  lw    $s3, 0x24($sp)
/* 0FB758 802D6DA8 8FB20020 */  lw    $s2, 0x20($sp)
/* 0FB75C 802D6DAC 8FB1001C */  lw    $s1, 0x1c($sp)
/* 0FB760 802D6DB0 8FB00018 */  lw    $s0, 0x18($sp)
/* 0FB764 802D6DB4 24020002 */  addiu $v0, $zero, 2
/* 0FB768 802D6DB8 03E00008 */  jr    $ra
/* 0FB76C 802D6DBC 27BD0038 */   addiu $sp, $sp, 0x38

/* 0FB770 802D6DC0 27BDFFC8 */  addiu $sp, $sp, -0x38
/* 0FB774 802D6DC4 AFB1001C */  sw    $s1, 0x1c($sp)
/* 0FB778 802D6DC8 0080882D */  daddu $s1, $a0, $zero
/* 0FB77C 802D6DCC AFBF0030 */  sw    $ra, 0x30($sp)
/* 0FB780 802D6DD0 AFB5002C */  sw    $s5, 0x2c($sp)
/* 0FB784 802D6DD4 AFB40028 */  sw    $s4, 0x28($sp)
/* 0FB788 802D6DD8 AFB30024 */  sw    $s3, 0x24($sp)
/* 0FB78C 802D6DDC AFB20020 */  sw    $s2, 0x20($sp)
/* 0FB790 802D6DE0 AFB00018 */  sw    $s0, 0x18($sp)
/* 0FB794 802D6DE4 8E30000C */  lw    $s0, 0xc($s1)
/* 0FB798 802D6DE8 8E050000 */  lw    $a1, ($s0)
/* 0FB79C 802D6DEC 0C0B1EAF */  jal   func_802C7ABC
/* 0FB7A0 802D6DF0 26100004 */   addiu $s0, $s0, 4
/* 0FB7A4 802D6DF4 8E050000 */  lw    $a1, ($s0)
/* 0FB7A8 802D6DF8 26100004 */  addiu $s0, $s0, 4
/* 0FB7AC 802D6DFC 0220202D */  daddu $a0, $s1, $zero
/* 0FB7B0 802D6E00 0C0B1EAF */  jal   func_802C7ABC
/* 0FB7B4 802D6E04 0040A82D */   daddu $s5, $v0, $zero
/* 0FB7B8 802D6E08 8E050000 */  lw    $a1, ($s0)
/* 0FB7BC 802D6E0C 26100004 */  addiu $s0, $s0, 4
/* 0FB7C0 802D6E10 0220202D */  daddu $a0, $s1, $zero
/* 0FB7C4 802D6E14 0C0B1EAF */  jal   func_802C7ABC
/* 0FB7C8 802D6E18 0040A02D */   daddu $s4, $v0, $zero
/* 0FB7CC 802D6E1C 8E050000 */  lw    $a1, ($s0)
/* 0FB7D0 802D6E20 26100004 */  addiu $s0, $s0, 4
/* 0FB7D4 802D6E24 0220202D */  daddu $a0, $s1, $zero
/* 0FB7D8 802D6E28 0C0B1EAF */  jal   func_802C7ABC
/* 0FB7DC 802D6E2C 0040982D */   daddu $s3, $v0, $zero
/* 0FB7E0 802D6E30 8E050000 */  lw    $a1, ($s0)
/* 0FB7E4 802D6E34 26100004 */  addiu $s0, $s0, 4
/* 0FB7E8 802D6E38 0220202D */  daddu $a0, $s1, $zero
/* 0FB7EC 802D6E3C 0C0B1EAF */  jal   func_802C7ABC
/* 0FB7F0 802D6E40 0040902D */   daddu $s2, $v0, $zero
/* 0FB7F4 802D6E44 0220202D */  daddu $a0, $s1, $zero
/* 0FB7F8 802D6E48 8E050000 */  lw    $a1, ($s0)
/* 0FB7FC 802D6E4C 0C0B1EAF */  jal   func_802C7ABC
/* 0FB800 802D6E50 0040802D */   daddu $s0, $v0, $zero
/* 0FB804 802D6E54 44940000 */  mtc1  $s4, $f0
/* 0FB808 802D6E58 00000000 */  nop   
/* 0FB80C 802D6E5C 46800020 */  cvt.s.w $f0, $f0
/* 0FB810 802D6E60 44050000 */  mfc1  $a1, $f0
/* 0FB814 802D6E64 44930000 */  mtc1  $s3, $f0
/* 0FB818 802D6E68 00000000 */  nop   
/* 0FB81C 802D6E6C 46800020 */  cvt.s.w $f0, $f0
/* 0FB820 802D6E70 44060000 */  mfc1  $a2, $f0
/* 0FB824 802D6E74 44920000 */  mtc1  $s2, $f0
/* 0FB828 802D6E78 00000000 */  nop   
/* 0FB82C 802D6E7C 46800020 */  cvt.s.w $f0, $f0
/* 0FB830 802D6E80 44070000 */  mfc1  $a3, $f0
/* 0FB834 802D6E84 02A0202D */  daddu $a0, $s5, $zero
/* 0FB838 802D6E88 AFB00010 */  sw    $s0, 0x10($sp)
/* 0FB83C 802D6E8C 0C04C6A5 */  jal   func_80131A94
/* 0FB840 802D6E90 AFA20014 */   sw    $v0, 0x14($sp)
/* 0FB844 802D6E94 AE220084 */  sw    $v0, 0x84($s1)
/* 0FB848 802D6E98 8FBF0030 */  lw    $ra, 0x30($sp)
/* 0FB84C 802D6E9C 8FB5002C */  lw    $s5, 0x2c($sp)
/* 0FB850 802D6EA0 8FB40028 */  lw    $s4, 0x28($sp)
/* 0FB854 802D6EA4 8FB30024 */  lw    $s3, 0x24($sp)
/* 0FB858 802D6EA8 8FB20020 */  lw    $s2, 0x20($sp)
/* 0FB85C 802D6EAC 8FB1001C */  lw    $s1, 0x1c($sp)
/* 0FB860 802D6EB0 8FB00018 */  lw    $s0, 0x18($sp)
/* 0FB864 802D6EB4 24020002 */  addiu $v0, $zero, 2
/* 0FB868 802D6EB8 03E00008 */  jr    $ra
/* 0FB86C 802D6EBC 27BD0038 */   addiu $sp, $sp, 0x38

/* 0FB870 802D6EC0 27BDFFC8 */  addiu $sp, $sp, -0x38
/* 0FB874 802D6EC4 AFB1001C */  sw    $s1, 0x1c($sp)
/* 0FB878 802D6EC8 0080882D */  daddu $s1, $a0, $zero
/* 0FB87C 802D6ECC AFBF0030 */  sw    $ra, 0x30($sp)
/* 0FB880 802D6ED0 AFB5002C */  sw    $s5, 0x2c($sp)
/* 0FB884 802D6ED4 AFB40028 */  sw    $s4, 0x28($sp)
/* 0FB888 802D6ED8 AFB30024 */  sw    $s3, 0x24($sp)
/* 0FB88C 802D6EDC AFB20020 */  sw    $s2, 0x20($sp)
/* 0FB890 802D6EE0 AFB00018 */  sw    $s0, 0x18($sp)
/* 0FB894 802D6EE4 8E30000C */  lw    $s0, 0xc($s1)
/* 0FB898 802D6EE8 8E050000 */  lw    $a1, ($s0)
/* 0FB89C 802D6EEC 0C0B1EAF */  jal   func_802C7ABC
/* 0FB8A0 802D6EF0 26100004 */   addiu $s0, $s0, 4
/* 0FB8A4 802D6EF4 8E050000 */  lw    $a1, ($s0)
/* 0FB8A8 802D6EF8 26100004 */  addiu $s0, $s0, 4
/* 0FB8AC 802D6EFC 0220202D */  daddu $a0, $s1, $zero
/* 0FB8B0 802D6F00 0C0B1EAF */  jal   func_802C7ABC
/* 0FB8B4 802D6F04 0040A82D */   daddu $s5, $v0, $zero
/* 0FB8B8 802D6F08 8E050000 */  lw    $a1, ($s0)
/* 0FB8BC 802D6F0C 26100004 */  addiu $s0, $s0, 4
/* 0FB8C0 802D6F10 0220202D */  daddu $a0, $s1, $zero
/* 0FB8C4 802D6F14 0C0B1EAF */  jal   func_802C7ABC
/* 0FB8C8 802D6F18 0040A02D */   daddu $s4, $v0, $zero
/* 0FB8CC 802D6F1C 8E050000 */  lw    $a1, ($s0)
/* 0FB8D0 802D6F20 26100004 */  addiu $s0, $s0, 4
/* 0FB8D4 802D6F24 0220202D */  daddu $a0, $s1, $zero
/* 0FB8D8 802D6F28 0C0B1EAF */  jal   func_802C7ABC
/* 0FB8DC 802D6F2C 0040982D */   daddu $s3, $v0, $zero
/* 0FB8E0 802D6F30 8E050000 */  lw    $a1, ($s0)
/* 0FB8E4 802D6F34 26100004 */  addiu $s0, $s0, 4
/* 0FB8E8 802D6F38 0220202D */  daddu $a0, $s1, $zero
/* 0FB8EC 802D6F3C 0C0B1EAF */  jal   func_802C7ABC
/* 0FB8F0 802D6F40 0040902D */   daddu $s2, $v0, $zero
/* 0FB8F4 802D6F44 0220202D */  daddu $a0, $s1, $zero
/* 0FB8F8 802D6F48 8E050000 */  lw    $a1, ($s0)
/* 0FB8FC 802D6F4C 0C0B1F6A */  jal   func_802C7DA8
/* 0FB900 802D6F50 0040802D */   daddu $s0, $v0, $zero
/* 0FB904 802D6F54 44940000 */  mtc1  $s4, $f0
/* 0FB908 802D6F58 00000000 */  nop   
/* 0FB90C 802D6F5C 46800020 */  cvt.s.w $f0, $f0
/* 0FB910 802D6F60 44050000 */  mfc1  $a1, $f0
/* 0FB914 802D6F64 44930000 */  mtc1  $s3, $f0
/* 0FB918 802D6F68 00000000 */  nop   
/* 0FB91C 802D6F6C 46800020 */  cvt.s.w $f0, $f0
/* 0FB920 802D6F70 44060000 */  mfc1  $a2, $f0
/* 0FB924 802D6F74 44920000 */  mtc1  $s2, $f0
/* 0FB928 802D6F78 00000000 */  nop   
/* 0FB92C 802D6F7C 46800020 */  cvt.s.w $f0, $f0
/* 0FB930 802D6F80 44070000 */  mfc1  $a3, $f0
/* 0FB934 802D6F84 02A0202D */  daddu $a0, $s5, $zero
/* 0FB938 802D6F88 AFB00010 */  sw    $s0, 0x10($sp)
/* 0FB93C 802D6F8C 0C04C6A5 */  jal   func_80131A94
/* 0FB940 802D6F90 AFA20014 */   sw    $v0, 0x14($sp)
/* 0FB944 802D6F94 0040202D */  daddu $a0, $v0, $zero
/* 0FB948 802D6F98 24054000 */  addiu $a1, $zero, 0x4000
/* 0FB94C 802D6F9C 0C04D052 */  jal   func_80134148
/* 0FB950 802D6FA0 AE240084 */   sw    $a0, 0x84($s1)
/* 0FB954 802D6FA4 8FBF0030 */  lw    $ra, 0x30($sp)
/* 0FB958 802D6FA8 8FB5002C */  lw    $s5, 0x2c($sp)
/* 0FB95C 802D6FAC 8FB40028 */  lw    $s4, 0x28($sp)
/* 0FB960 802D6FB0 8FB30024 */  lw    $s3, 0x24($sp)
/* 0FB964 802D6FB4 8FB20020 */  lw    $s2, 0x20($sp)
/* 0FB968 802D6FB8 8FB1001C */  lw    $s1, 0x1c($sp)
/* 0FB96C 802D6FBC 8FB00018 */  lw    $s0, 0x18($sp)
/* 0FB970 802D6FC0 24020002 */  addiu $v0, $zero, 2
/* 0FB974 802D6FC4 03E00008 */  jr    $ra
/* 0FB978 802D6FC8 27BD0038 */   addiu $sp, $sp, 0x38

/* 0FB97C 802D6FCC 27BDFFE8 */  addiu $sp, $sp, -0x18
/* 0FB980 802D6FD0 AFBF0010 */  sw    $ra, 0x10($sp)
/* 0FB984 802D6FD4 8C82000C */  lw    $v0, 0xc($a0)
/* 0FB988 802D6FD8 0C0B1EAF */  jal   func_802C7ABC
/* 0FB98C 802D6FDC 8C450000 */   lw    $a1, ($v0)
/* 0FB990 802D6FE0 0C04CE7F */  jal   func_801339FC
/* 0FB994 802D6FE4 0040202D */   daddu $a0, $v0, $zero
/* 0FB998 802D6FE8 8FBF0010 */  lw    $ra, 0x10($sp)
/* 0FB99C 802D6FEC 24020002 */  addiu $v0, $zero, 2
/* 0FB9A0 802D6FF0 03E00008 */  jr    $ra
/* 0FB9A4 802D6FF4 27BD0018 */   addiu $sp, $sp, 0x18

/* 0FB9A8 802D6FF8 27BDFFE0 */  addiu $sp, $sp, -0x20
/* 0FB9AC 802D6FFC AFB10014 */  sw    $s1, 0x14($sp)
/* 0FB9B0 802D7000 0080882D */  daddu $s1, $a0, $zero
/* 0FB9B4 802D7004 AFBF0018 */  sw    $ra, 0x18($sp)
/* 0FB9B8 802D7008 AFB00010 */  sw    $s0, 0x10($sp)
/* 0FB9BC 802D700C 8E30000C */  lw    $s0, 0xc($s1)
/* 0FB9C0 802D7010 8E050000 */  lw    $a1, ($s0)
/* 0FB9C4 802D7014 0C0B1EAF */  jal   func_802C7ABC
/* 0FB9C8 802D7018 26100004 */   addiu $s0, $s0, 4
/* 0FB9CC 802D701C 8E100000 */  lw    $s0, ($s0)
/* 0FB9D0 802D7020 0C039DCF */  jal   func_800E773C
/* 0FB9D4 802D7024 0040202D */   daddu $a0, $v0, $zero
/* 0FB9D8 802D7028 0220202D */  daddu $a0, $s1, $zero
/* 0FB9DC 802D702C 0040302D */  daddu $a2, $v0, $zero
/* 0FB9E0 802D7030 0C0B2026 */  jal   func_802C8098
/* 0FB9E4 802D7034 0200282D */   daddu $a1, $s0, $zero
/* 0FB9E8 802D7038 8FBF0018 */  lw    $ra, 0x18($sp)
/* 0FB9EC 802D703C 8FB10014 */  lw    $s1, 0x14($sp)
/* 0FB9F0 802D7040 8FB00010 */  lw    $s0, 0x10($sp)
/* 0FB9F4 802D7044 24020002 */  addiu $v0, $zero, 2
/* 0FB9F8 802D7048 03E00008 */  jr    $ra
/* 0FB9FC 802D704C 27BD0020 */   addiu $sp, $sp, 0x20

/* 0FBA00 802D7050 27BDFFE8 */  addiu $sp, $sp, -0x18
/* 0FBA04 802D7054 AFBF0014 */  sw    $ra, 0x14($sp)
/* 0FBA08 802D7058 AFB00010 */  sw    $s0, 0x10($sp)
/* 0FBA0C 802D705C 8C82000C */  lw    $v0, 0xc($a0)
/* 0FBA10 802D7060 0C0B1EAF */  jal   func_802C7ABC
/* 0FBA14 802D7064 8C450000 */   lw    $a1, ($v0)
/* 0FBA18 802D7068 0040282D */  daddu $a1, $v0, $zero
/* 0FBA1C 802D706C 0000202D */  daddu $a0, $zero, $zero
/* 0FBA20 802D7070 3C108011 */  lui   $s0, 0x8011
/* 0FBA24 802D7074 2610F290 */  addiu $s0, $s0, -0xd70
/* 0FBA28 802D7078 0200182D */  daddu $v1, $s0, $zero
.L802D707C:
/* 0FBA2C 802D707C 846200B4 */  lh    $v0, 0xb4($v1)
/* 0FBA30 802D7080 50450001 */  beql  $v0, $a1, .L802D7088
/* 0FBA34 802D7084 A46000B4 */   sh    $zero, 0xb4($v1)
.L802D7088:
/* 0FBA38 802D7088 24840001 */  addiu $a0, $a0, 1
/* 0FBA3C 802D708C 28820080 */  slti  $v0, $a0, 0x80
/* 0FBA40 802D7090 1440FFFA */  bnez  $v0, .L802D707C
/* 0FBA44 802D7094 24630002 */   addiu $v1, $v1, 2
/* 0FBA48 802D7098 0000202D */  daddu $a0, $zero, $zero
/* 0FBA4C 802D709C 0200182D */  daddu $v1, $s0, $zero
.L802D70A0:
/* 0FBA50 802D70A0 84620208 */  lh    $v0, 0x208($v1)
/* 0FBA54 802D70A4 50450001 */  beql  $v0, $a1, .L802D70AC
/* 0FBA58 802D70A8 A4600208 */   sh    $zero, 0x208($v1)
.L802D70AC:
/* 0FBA5C 802D70AC 24840001 */  addiu $a0, $a0, 1
/* 0FBA60 802D70B0 28820040 */  slti  $v0, $a0, 0x40
/* 0FBA64 802D70B4 1440FFFA */  bnez  $v0, .L802D70A0
/* 0FBA68 802D70B8 24630002 */   addiu $v1, $v1, 2
/* 0FBA6C 802D70BC 8FBF0014 */  lw    $ra, 0x14($sp)
/* 0FBA70 802D70C0 8FB00010 */  lw    $s0, 0x10($sp)
/* 0FBA74 802D70C4 24020002 */  addiu $v0, $zero, 2
/* 0FBA78 802D70C8 03E00008 */  jr    $ra
/* 0FBA7C 802D70CC 27BD0018 */   addiu $sp, $sp, 0x18

/* 0FBA80 802D70D0 27BDFFD8 */  addiu $sp, $sp, -0x28
/* 0FBA84 802D70D4 AFB10014 */  sw    $s1, 0x14($sp)
/* 0FBA88 802D70D8 0080882D */  daddu $s1, $a0, $zero
/* 0FBA8C 802D70DC AFBF0020 */  sw    $ra, 0x20($sp)
/* 0FBA90 802D70E0 AFB3001C */  sw    $s3, 0x1c($sp)
/* 0FBA94 802D70E4 AFB20018 */  sw    $s2, 0x18($sp)
/* 0FBA98 802D70E8 AFB00010 */  sw    $s0, 0x10($sp)
/* 0FBA9C 802D70EC 8E30000C */  lw    $s0, 0xc($s1)
/* 0FBAA0 802D70F0 8E050000 */  lw    $a1, ($s0)
/* 0FBAA4 802D70F4 0C0B1EAF */  jal   func_802C7ABC
/* 0FBAA8 802D70F8 26100004 */   addiu $s0, $s0, 4
/* 0FBAAC 802D70FC 8E050000 */  lw    $a1, ($s0)
/* 0FBAB0 802D7100 26100004 */  addiu $s0, $s0, 4
/* 0FBAB4 802D7104 0220202D */  daddu $a0, $s1, $zero
/* 0FBAB8 802D7108 0C0B1EAF */  jal   func_802C7ABC
/* 0FBABC 802D710C 0040982D */   daddu $s3, $v0, $zero
/* 0FBAC0 802D7110 8E050000 */  lw    $a1, ($s0)
/* 0FBAC4 802D7114 26100004 */  addiu $s0, $s0, 4
/* 0FBAC8 802D7118 0220202D */  daddu $a0, $s1, $zero
/* 0FBACC 802D711C 0C0B1EAF */  jal   func_802C7ABC
/* 0FBAD0 802D7120 0040902D */   daddu $s2, $v0, $zero
/* 0FBAD4 802D7124 0220202D */  daddu $a0, $s1, $zero
/* 0FBAD8 802D7128 8E050000 */  lw    $a1, ($s0)
/* 0FBADC 802D712C 0C0B1EAF */  jal   func_802C7ABC
/* 0FBAE0 802D7130 0040882D */   daddu $s1, $v0, $zero
/* 0FBAE4 802D7134 0260202D */  daddu $a0, $s3, $zero
/* 0FBAE8 802D7138 0C04C3D6 */  jal   func_80130F58
/* 0FBAEC 802D713C 0040802D */   daddu $s0, $v0, $zero
/* 0FBAF0 802D7140 0040182D */  daddu $v1, $v0, $zero
/* 0FBAF4 802D7144 44920000 */  mtc1  $s2, $f0
/* 0FBAF8 802D7148 00000000 */  nop   
/* 0FBAFC 802D714C 46800020 */  cvt.s.w $f0, $f0
/* 0FBB00 802D7150 E4600008 */  swc1  $f0, 8($v1)
/* 0FBB04 802D7154 44910000 */  mtc1  $s1, $f0
/* 0FBB08 802D7158 00000000 */  nop   
/* 0FBB0C 802D715C 46800020 */  cvt.s.w $f0, $f0
/* 0FBB10 802D7160 E460000C */  swc1  $f0, 0xc($v1)
/* 0FBB14 802D7164 44900000 */  mtc1  $s0, $f0
/* 0FBB18 802D7168 00000000 */  nop   
/* 0FBB1C 802D716C 46800020 */  cvt.s.w $f0, $f0
/* 0FBB20 802D7170 E4600010 */  swc1  $f0, 0x10($v1)
/* 0FBB24 802D7174 8FBF0020 */  lw    $ra, 0x20($sp)
/* 0FBB28 802D7178 8FB3001C */  lw    $s3, 0x1c($sp)
/* 0FBB2C 802D717C 8FB20018 */  lw    $s2, 0x18($sp)
/* 0FBB30 802D7180 8FB10014 */  lw    $s1, 0x14($sp)
/* 0FBB34 802D7184 8FB00010 */  lw    $s0, 0x10($sp)
/* 0FBB38 802D7188 24020002 */  addiu $v0, $zero, 2
/* 0FBB3C 802D718C 03E00008 */  jr    $ra
/* 0FBB40 802D7190 27BD0028 */   addiu $sp, $sp, 0x28

/* 0FBB44 802D7194 27BDFFE0 */  addiu $sp, $sp, -0x20
/* 0FBB48 802D7198 AFB10014 */  sw    $s1, 0x14($sp)
/* 0FBB4C 802D719C 0080882D */  daddu $s1, $a0, $zero
/* 0FBB50 802D71A0 AFBF001C */  sw    $ra, 0x1c($sp)
/* 0FBB54 802D71A4 AFB20018 */  sw    $s2, 0x18($sp)
/* 0FBB58 802D71A8 AFB00010 */  sw    $s0, 0x10($sp)
/* 0FBB5C 802D71AC 8E30000C */  lw    $s0, 0xc($s1)
/* 0FBB60 802D71B0 8E050000 */  lw    $a1, ($s0)
/* 0FBB64 802D71B4 0C0B1EAF */  jal   func_802C7ABC
/* 0FBB68 802D71B8 26100004 */   addiu $s0, $s0, 4
/* 0FBB6C 802D71BC 0220202D */  daddu $a0, $s1, $zero
/* 0FBB70 802D71C0 8E050004 */  lw    $a1, 4($s0)
/* 0FBB74 802D71C4 8E120000 */  lw    $s2, ($s0)
/* 0FBB78 802D71C8 0C0B1EAF */  jal   func_802C7ABC
/* 0FBB7C 802D71CC 0040882D */   daddu $s1, $v0, $zero
/* 0FBB80 802D71D0 0220202D */  daddu $a0, $s1, $zero
/* 0FBB84 802D71D4 0C04C3D6 */  jal   func_80130F58
/* 0FBB88 802D71D8 0040802D */   daddu $s0, $v0, $zero
/* 0FBB8C 802D71DC 12000004 */  beqz  $s0, .L802D71F0
/* 0FBB90 802D71E0 0040202D */   daddu $a0, $v0, $zero
/* 0FBB94 802D71E4 8C820000 */  lw    $v0, ($a0)
/* 0FBB98 802D71E8 080B5C7F */  j     func_802D71FC
/* 0FBB9C 802D71EC 00521025 */   or    $v0, $v0, $s2

.L802D71F0:
/* 0FBBA0 802D71F0 8C820000 */  lw    $v0, ($a0)
/* 0FBBA4 802D71F4 00121827 */  nor   $v1, $zero, $s2
/* 0FBBA8 802D71F8 00431024 */  and   $v0, $v0, $v1
func_802D71FC:
/* 0FBBAC 802D71FC AC820000 */  sw    $v0, ($a0)
/* 0FBBB0 802D7200 8FBF001C */  lw    $ra, 0x1c($sp)
/* 0FBBB4 802D7204 8FB20018 */  lw    $s2, 0x18($sp)
/* 0FBBB8 802D7208 8FB10014 */  lw    $s1, 0x14($sp)
/* 0FBBBC 802D720C 8FB00010 */  lw    $s0, 0x10($sp)
/* 0FBBC0 802D7210 24020002 */  addiu $v0, $zero, 2
/* 0FBBC4 802D7214 03E00008 */  jr    $ra
/* 0FBBC8 802D7218 27BD0020 */   addiu $sp, $sp, 0x20

/* 0FBBCC 802D721C 27BDFFE0 */  addiu $sp, $sp, -0x20
/* 0FBBD0 802D7220 AFB10014 */  sw    $s1, 0x14($sp)
/* 0FBBD4 802D7224 0080882D */  daddu $s1, $a0, $zero
/* 0FBBD8 802D7228 AFBF0018 */  sw    $ra, 0x18($sp)
/* 0FBBDC 802D722C AFB00010 */  sw    $s0, 0x10($sp)
/* 0FBBE0 802D7230 8E30000C */  lw    $s0, 0xc($s1)
/* 0FBBE4 802D7234 8E050000 */  lw    $a1, ($s0)
/* 0FBBE8 802D7238 0C0B1EAF */  jal   func_802C7ABC
/* 0FBBEC 802D723C 26100004 */   addiu $s0, $s0, 4
/* 0FBBF0 802D7240 0220202D */  daddu $a0, $s1, $zero
/* 0FBBF4 802D7244 8E050000 */  lw    $a1, ($s0)
/* 0FBBF8 802D7248 0C0B1EAF */  jal   func_802C7ABC
/* 0FBBFC 802D724C 0040802D */   daddu $s0, $v0, $zero
/* 0FBC00 802D7250 0200202D */  daddu $a0, $s0, $zero
/* 0FBC04 802D7254 0C04C3D6 */  jal   func_80130F58
/* 0FBC08 802D7258 0040802D */   daddu $s0, $v0, $zero
/* 0FBC0C 802D725C A050002F */  sb    $s0, 0x2f($v0)
/* 0FBC10 802D7260 8FBF0018 */  lw    $ra, 0x18($sp)
/* 0FBC14 802D7264 8FB10014 */  lw    $s1, 0x14($sp)
/* 0FBC18 802D7268 8FB00010 */  lw    $s0, 0x10($sp)
/* 0FBC1C 802D726C 24020002 */  addiu $v0, $zero, 2
/* 0FBC20 802D7270 03E00008 */  jr    $ra
/* 0FBC24 802D7274 27BD0020 */   addiu $sp, $sp, 0x20

/* 0FBC28 802D7278 27BDFFE8 */  addiu $sp, $sp, -0x18
/* 0FBC2C 802D727C AFB00010 */  sw    $s0, 0x10($sp)
/* 0FBC30 802D7280 0080802D */  daddu $s0, $a0, $zero
/* 0FBC34 802D7284 AFBF0014 */  sw    $ra, 0x14($sp)
/* 0FBC38 802D7288 8E02000C */  lw    $v0, 0xc($s0)
/* 0FBC3C 802D728C 0C0B1EAF */  jal   func_802C7ABC
/* 0FBC40 802D7290 8C450000 */   lw    $a1, ($v0)
/* 0FBC44 802D7294 0C03A830 */  jal   func_800EA0C0
/* 0FBC48 802D7298 0040202D */   daddu $a0, $v0, $zero
/* 0FBC4C 802D729C AE020084 */  sw    $v0, 0x84($s0)
/* 0FBC50 802D72A0 8FBF0014 */  lw    $ra, 0x14($sp)
/* 0FBC54 802D72A4 8FB00010 */  lw    $s0, 0x10($sp)
/* 0FBC58 802D72A8 24020002 */  addiu $v0, $zero, 2
/* 0FBC5C 802D72AC 03E00008 */  jr    $ra
/* 0FBC60 802D72B0 27BD0018 */   addiu $sp, $sp, 0x18

/* 0FBC64 802D72B4 27BDFFE8 */  addiu $sp, $sp, -0x18
/* 0FBC68 802D72B8 AFB00010 */  sw    $s0, 0x10($sp)
/* 0FBC6C 802D72BC 0080802D */  daddu $s0, $a0, $zero
/* 0FBC70 802D72C0 AFBF0014 */  sw    $ra, 0x14($sp)
/* 0FBC74 802D72C4 8E02000C */  lw    $v0, 0xc($s0)
/* 0FBC78 802D72C8 0C0B1EAF */  jal   func_802C7ABC
/* 0FBC7C 802D72CC 8C450000 */   lw    $a1, ($v0)
/* 0FBC80 802D72D0 0C03A84A */  jal   func_800EA128
/* 0FBC84 802D72D4 0040202D */   daddu $a0, $v0, $zero
/* 0FBC88 802D72D8 AE020084 */  sw    $v0, 0x84($s0)
/* 0FBC8C 802D72DC 8FBF0014 */  lw    $ra, 0x14($sp)
/* 0FBC90 802D72E0 8FB00010 */  lw    $s0, 0x10($sp)
/* 0FBC94 802D72E4 24020002 */  addiu $v0, $zero, 2
/* 0FBC98 802D72E8 03E00008 */  jr    $ra
/* 0FBC9C 802D72EC 27BD0018 */   addiu $sp, $sp, 0x18

/* 0FBCA0 802D72F0 27BDFFE8 */  addiu $sp, $sp, -0x18
/* 0FBCA4 802D72F4 AFB00010 */  sw    $s0, 0x10($sp)
/* 0FBCA8 802D72F8 0080802D */  daddu $s0, $a0, $zero
/* 0FBCAC 802D72FC AFBF0014 */  sw    $ra, 0x14($sp)
/* 0FBCB0 802D7300 8E02000C */  lw    $v0, 0xc($s0)
/* 0FBCB4 802D7304 0C0B1EAF */  jal   func_802C7ABC
/* 0FBCB8 802D7308 8C450000 */   lw    $a1, ($v0)
/* 0FBCBC 802D730C 0C03A85C */  jal   func_800EA170
/* 0FBCC0 802D7310 0040202D */   daddu $a0, $v0, $zero
/* 0FBCC4 802D7314 AE020084 */  sw    $v0, 0x84($s0)
/* 0FBCC8 802D7318 8FBF0014 */  lw    $ra, 0x14($sp)
/* 0FBCCC 802D731C 8FB00010 */  lw    $s0, 0x10($sp)
/* 0FBCD0 802D7320 24020002 */  addiu $v0, $zero, 2
/* 0FBCD4 802D7324 03E00008 */  jr    $ra
/* 0FBCD8 802D7328 27BD0018 */   addiu $sp, $sp, 0x18

/* 0FBCDC 802D732C 27BDFFE0 */  addiu $sp, $sp, -0x20
/* 0FBCE0 802D7330 AFB20018 */  sw    $s2, 0x18($sp)
/* 0FBCE4 802D7334 0080902D */  daddu $s2, $a0, $zero
/* 0FBCE8 802D7338 AFBF001C */  sw    $ra, 0x1c($sp)
/* 0FBCEC 802D733C AFB10014 */  sw    $s1, 0x14($sp)
/* 0FBCF0 802D7340 AFB00010 */  sw    $s0, 0x10($sp)
/* 0FBCF4 802D7344 8E50000C */  lw    $s0, 0xc($s2)
/* 0FBCF8 802D7348 8E050000 */  lw    $a1, ($s0)
/* 0FBCFC 802D734C 0C0B1EAF */  jal   func_802C7ABC
/* 0FBD00 802D7350 26100004 */   addiu $s0, $s0, 4
/* 0FBD04 802D7354 3C038008 */  lui   $v1, 0x8008
/* 0FBD08 802D7358 246378E0 */  addiu $v1, $v1, 0x78e0
/* 0FBD0C 802D735C 00028940 */  sll   $s1, $v0, 5
/* 0FBD10 802D7360 02238821 */  addu  $s1, $s1, $v1
/* 0FBD14 802D7364 8E050000 */  lw    $a1, ($s0)
/* 0FBD18 802D7368 8226001B */  lb    $a2, 0x1b($s1)
/* 0FBD1C 802D736C 8E100004 */  lw    $s0, 4($s0)
/* 0FBD20 802D7370 0C0B2026 */  jal   func_802C8098
/* 0FBD24 802D7374 0240202D */   daddu $a0, $s2, $zero
/* 0FBD28 802D7378 0240202D */  daddu $a0, $s2, $zero
/* 0FBD2C 802D737C 8226001C */  lb    $a2, 0x1c($s1)
/* 0FBD30 802D7380 0C0B2026 */  jal   func_802C8098
/* 0FBD34 802D7384 0200282D */   daddu $a1, $s0, $zero
/* 0FBD38 802D7388 8FBF001C */  lw    $ra, 0x1c($sp)
/* 0FBD3C 802D738C 8FB20018 */  lw    $s2, 0x18($sp)
/* 0FBD40 802D7390 8FB10014 */  lw    $s1, 0x14($sp)
/* 0FBD44 802D7394 8FB00010 */  lw    $s0, 0x10($sp)
/* 0FBD48 802D7398 24020002 */  addiu $v0, $zero, 2
/* 0FBD4C 802D739C 03E00008 */  jr    $ra
/* 0FBD50 802D73A0 27BD0020 */   addiu $sp, $sp, 0x20

/* 0FBD54 802D73A4 27BDFFE0 */  addiu $sp, $sp, -0x20
/* 0FBD58 802D73A8 AFB20018 */  sw    $s2, 0x18($sp)
/* 0FBD5C 802D73AC 0080902D */  daddu $s2, $a0, $zero
/* 0FBD60 802D73B0 AFBF001C */  sw    $ra, 0x1c($sp)
/* 0FBD64 802D73B4 AFB10014 */  sw    $s1, 0x14($sp)
/* 0FBD68 802D73B8 AFB00010 */  sw    $s0, 0x10($sp)
/* 0FBD6C 802D73BC 8E51000C */  lw    $s1, 0xc($s2)
/* 0FBD70 802D73C0 54A00001 */  bnezl $a1, .L802D73C8
/* 0FBD74 802D73C4 AE400070 */   sw    $zero, 0x70($s2)
.L802D73C8:
/* 0FBD78 802D73C8 8E430070 */  lw    $v1, 0x70($s2)
/* 0FBD7C 802D73CC 10600005 */  beqz  $v1, .L802D73E4
/* 0FBD80 802D73D0 24020001 */   addiu $v0, $zero, 1
/* 0FBD84 802D73D4 10620014 */  beq   $v1, $v0, .L802D7428
/* 0FBD88 802D73D8 00000000 */   nop   
/* 0FBD8C 802D73DC 080B5D11 */  j     func_802D7444
/* 0FBD90 802D73E0 0000102D */   daddu $v0, $zero, $zero

.L802D73E4:
/* 0FBD94 802D73E4 8E250000 */  lw    $a1, ($s1)
/* 0FBD98 802D73E8 26310004 */  addiu $s1, $s1, 4
/* 0FBD9C 802D73EC 0C0B1EAF */  jal   func_802C7ABC
/* 0FBDA0 802D73F0 0240202D */   daddu $a0, $s2, $zero
/* 0FBDA4 802D73F4 8E250000 */  lw    $a1, ($s1)
/* 0FBDA8 802D73F8 26310004 */  addiu $s1, $s1, 4
/* 0FBDAC 802D73FC 0240202D */  daddu $a0, $s2, $zero
/* 0FBDB0 802D7400 0C0B1EAF */  jal   func_802C7ABC
/* 0FBDB4 802D7404 0040802D */   daddu $s0, $v0, $zero
/* 0FBDB8 802D7408 0200202D */  daddu $a0, $s0, $zero
/* 0FBDBC 802D740C 8E260000 */  lw    $a2, ($s1)
/* 0FBDC0 802D7410 0C04C6C0 */  jal   func_80131B00
/* 0FBDC4 802D7414 0040282D */   daddu $a1, $v0, $zero
/* 0FBDC8 802D7418 AE420074 */  sw    $v0, 0x74($s2)
/* 0FBDCC 802D741C 24020001 */  addiu $v0, $zero, 1
/* 0FBDD0 802D7420 080B5D10 */  j     func_802D7440
/* 0FBDD4 802D7424 AE420070 */   sw    $v0, 0x70($s2)

.L802D7428:
/* 0FBDD8 802D7428 8E440074 */  lw    $a0, 0x74($s2)
/* 0FBDDC 802D742C 0C04C3D6 */  jal   func_80130F58
/* 0FBDE0 802D7430 00000000 */   nop   
/* 0FBDE4 802D7434 0040182D */  daddu $v1, $v0, $zero
/* 0FBDE8 802D7438 10600002 */  beqz  $v1, .L802D7444
/* 0FBDEC 802D743C 24020002 */   addiu $v0, $zero, 2
func_802D7440:
/* 0FBDF0 802D7440 0000102D */  daddu $v0, $zero, $zero
func_802D7444:
.L802D7444:
/* 0FBDF4 802D7444 8FBF001C */  lw    $ra, 0x1c($sp)
/* 0FBDF8 802D7448 8FB20018 */  lw    $s2, 0x18($sp)
/* 0FBDFC 802D744C 8FB10014 */  lw    $s1, 0x14($sp)
/* 0FBE00 802D7450 8FB00010 */  lw    $s0, 0x10($sp)
/* 0FBE04 802D7454 03E00008 */  jr    $ra
/* 0FBE08 802D7458 27BD0020 */   addiu $sp, $sp, 0x20

/* 0FBE0C 802D745C 00000000 */  nop   
func_802D7460:
/* 0FBE10 802D7460 27BDFFD8 */  addiu $sp, $sp, -0x28
/* 0FBE14 802D7464 24E2001E */  addiu $v0, $a3, 0x1e
/* 0FBE18 802D7468 44820000 */  mtc1  $v0, $f0
/* 0FBE1C 802D746C 00000000 */  nop   
/* 0FBE20 802D7470 46800020 */  cvt.s.w $f0, $f0
/* 0FBE24 802D7474 000717C2 */  srl   $v0, $a3, 0x1f
/* 0FBE28 802D7478 00E23821 */  addu  $a3, $a3, $v0
/* 0FBE2C 802D747C 00073843 */  sra   $a3, $a3, 1
/* 0FBE30 802D7480 24E7000A */  addiu $a3, $a3, 0xa
/* 0FBE34 802D7484 44861000 */  mtc1  $a2, $f2
/* 0FBE38 802D7488 44056000 */  mfc1  $a1, $f12
/* 0FBE3C 802D748C 44067000 */  mfc1  $a2, $f14
/* 0FBE40 802D7490 2402001E */  addiu $v0, $zero, 0x1e
/* 0FBE44 802D7494 AFA70018 */  sw    $a3, 0x18($sp)
/* 0FBE48 802D7498 44071000 */  mfc1  $a3, $f2
/* 0FBE4C 802D749C 24040001 */  addiu $a0, $zero, 1
/* 0FBE50 802D74A0 AFBF0020 */  sw    $ra, 0x20($sp)
/* 0FBE54 802D74A4 E7A00010 */  swc1  $f0, 0x10($sp)
/* 0FBE58 802D74A8 E7A00014 */  swc1  $f0, 0x14($sp)
/* 0FBE5C 802D74AC 0C01C154 */  jal   func_80070550
/* 0FBE60 802D74B0 AFA2001C */   sw    $v0, 0x1c($sp)
/* 0FBE64 802D74B4 8FBF0020 */  lw    $ra, 0x20($sp)
/* 0FBE68 802D74B8 03E00008 */  jr    $ra
/* 0FBE6C 802D74BC 27BD0028 */   addiu $sp, $sp, 0x28

func_802D74C0:
/* 0FBE70 802D74C0 27BDFFD8 */  addiu $sp, $sp, -0x28
/* 0FBE74 802D74C4 24E2001E */  addiu $v0, $a3, 0x1e
/* 0FBE78 802D74C8 44820000 */  mtc1  $v0, $f0
/* 0FBE7C 802D74CC 00000000 */  nop   
/* 0FBE80 802D74D0 46800020 */  cvt.s.w $f0, $f0
/* 0FBE84 802D74D4 000717C2 */  srl   $v0, $a3, 0x1f
/* 0FBE88 802D74D8 00E23821 */  addu  $a3, $a3, $v0
/* 0FBE8C 802D74DC 00073843 */  sra   $a3, $a3, 1
/* 0FBE90 802D74E0 24E7000A */  addiu $a3, $a3, 0xa
/* 0FBE94 802D74E4 44861000 */  mtc1  $a2, $f2
/* 0FBE98 802D74E8 44056000 */  mfc1  $a1, $f12
/* 0FBE9C 802D74EC 44067000 */  mfc1  $a2, $f14
/* 0FBEA0 802D74F0 2402001E */  addiu $v0, $zero, 0x1e
/* 0FBEA4 802D74F4 AFA70018 */  sw    $a3, 0x18($sp)
/* 0FBEA8 802D74F8 44071000 */  mfc1  $a3, $f2
/* 0FBEAC 802D74FC 24040002 */  addiu $a0, $zero, 2
/* 0FBEB0 802D7500 AFBF0020 */  sw    $ra, 0x20($sp)
/* 0FBEB4 802D7504 E7A00010 */  swc1  $f0, 0x10($sp)
/* 0FBEB8 802D7508 E7A00014 */  swc1  $f0, 0x14($sp)
/* 0FBEBC 802D750C 0C01C154 */  jal   func_80070550
/* 0FBEC0 802D7510 AFA2001C */   sw    $v0, 0x1c($sp)
/* 0FBEC4 802D7514 8FBF0020 */  lw    $ra, 0x20($sp)
/* 0FBEC8 802D7518 03E00008 */  jr    $ra
/* 0FBECC 802D751C 27BD0028 */   addiu $sp, $sp, 0x28

/* 0FBED0 802D7520 27BDFFC0 */  addiu $sp, $sp, -0x40
/* 0FBED4 802D7524 AFB1001C */  sw    $s1, 0x1c($sp)
/* 0FBED8 802D7528 0080882D */  daddu $s1, $a0, $zero
/* 0FBEDC 802D752C AFBF0020 */  sw    $ra, 0x20($sp)
/* 0FBEE0 802D7530 AFB00018 */  sw    $s0, 0x18($sp)
/* 0FBEE4 802D7534 F7B80038 */  sdc1  $f24, 0x38($sp)
/* 0FBEE8 802D7538 F7B60030 */  sdc1  $f22, 0x30($sp)
/* 0FBEEC 802D753C F7B40028 */  sdc1  $f20, 0x28($sp)
/* 0FBEF0 802D7540 8E30000C */  lw    $s0, 0xc($s1)
/* 0FBEF4 802D7544 8E050000 */  lw    $a1, ($s0)
/* 0FBEF8 802D7548 0C0B210B */  jal   func_802C842C
/* 0FBEFC 802D754C 26100004 */   addiu $s0, $s0, 4
/* 0FBF00 802D7550 8E050000 */  lw    $a1, ($s0)
/* 0FBF04 802D7554 26100004 */  addiu $s0, $s0, 4
/* 0FBF08 802D7558 0220202D */  daddu $a0, $s1, $zero
/* 0FBF0C 802D755C 0C0B210B */  jal   func_802C842C
/* 0FBF10 802D7560 46000606 */   mov.s $f24, $f0
/* 0FBF14 802D7564 8E050000 */  lw    $a1, ($s0)
/* 0FBF18 802D7568 26100004 */  addiu $s0, $s0, 4
/* 0FBF1C 802D756C 0220202D */  daddu $a0, $s1, $zero
/* 0FBF20 802D7570 0C0B210B */  jal   func_802C842C
/* 0FBF24 802D7574 46000586 */   mov.s $f22, $f0
/* 0FBF28 802D7578 0220202D */  daddu $a0, $s1, $zero
/* 0FBF2C 802D757C 8E050000 */  lw    $a1, ($s0)
/* 0FBF30 802D7580 0C0B1EAF */  jal   func_802C7ABC
/* 0FBF34 802D7584 46000506 */   mov.s $f20, $f0
/* 0FBF38 802D7588 0040382D */  daddu $a3, $v0, $zero
/* 0FBF3C 802D758C 4600C306 */  mov.s $f12, $f24
/* 0FBF40 802D7590 4406A000 */  mfc1  $a2, $f20
/* 0FBF44 802D7594 0C0B5D18 */  jal   func_802D7460
/* 0FBF48 802D7598 4600B386 */   mov.s $f14, $f22
/* 0FBF4C 802D759C 24042055 */  addiu $a0, $zero, 0x2055
/* 0FBF50 802D75A0 4406C000 */  mfc1  $a2, $f24
/* 0FBF54 802D75A4 4407B000 */  mfc1  $a3, $f22
/* 0FBF58 802D75A8 0000282D */  daddu $a1, $zero, $zero
/* 0FBF5C 802D75AC 0C052757 */  jal   func_80149D5C
/* 0FBF60 802D75B0 E7B40010 */   swc1  $f20, 0x10($sp)
/* 0FBF64 802D75B4 8FBF0020 */  lw    $ra, 0x20($sp)
/* 0FBF68 802D75B8 8FB1001C */  lw    $s1, 0x1c($sp)
/* 0FBF6C 802D75BC 8FB00018 */  lw    $s0, 0x18($sp)
/* 0FBF70 802D75C0 D7B80038 */  ldc1  $f24, 0x38($sp)
/* 0FBF74 802D75C4 D7B60030 */  ldc1  $f22, 0x30($sp)
/* 0FBF78 802D75C8 D7B40028 */  ldc1  $f20, 0x28($sp)
/* 0FBF7C 802D75CC 24020002 */  addiu $v0, $zero, 2
/* 0FBF80 802D75D0 03E00008 */  jr    $ra
/* 0FBF84 802D75D4 27BD0040 */   addiu $sp, $sp, 0x40

/* 0FBF88 802D75D8 27BDFFC0 */  addiu $sp, $sp, -0x40
/* 0FBF8C 802D75DC AFB1001C */  sw    $s1, 0x1c($sp)
/* 0FBF90 802D75E0 0080882D */  daddu $s1, $a0, $zero
/* 0FBF94 802D75E4 AFBF0020 */  sw    $ra, 0x20($sp)
/* 0FBF98 802D75E8 AFB00018 */  sw    $s0, 0x18($sp)
/* 0FBF9C 802D75EC F7B80038 */  sdc1  $f24, 0x38($sp)
/* 0FBFA0 802D75F0 F7B60030 */  sdc1  $f22, 0x30($sp)
/* 0FBFA4 802D75F4 F7B40028 */  sdc1  $f20, 0x28($sp)
/* 0FBFA8 802D75F8 8E30000C */  lw    $s0, 0xc($s1)
/* 0FBFAC 802D75FC 8E050000 */  lw    $a1, ($s0)
/* 0FBFB0 802D7600 0C0B210B */  jal   func_802C842C
/* 0FBFB4 802D7604 26100004 */   addiu $s0, $s0, 4
/* 0FBFB8 802D7608 8E050000 */  lw    $a1, ($s0)
/* 0FBFBC 802D760C 26100004 */  addiu $s0, $s0, 4
/* 0FBFC0 802D7610 0220202D */  daddu $a0, $s1, $zero
/* 0FBFC4 802D7614 0C0B210B */  jal   func_802C842C
/* 0FBFC8 802D7618 46000606 */   mov.s $f24, $f0
/* 0FBFCC 802D761C 8E050000 */  lw    $a1, ($s0)
/* 0FBFD0 802D7620 26100004 */  addiu $s0, $s0, 4
/* 0FBFD4 802D7624 0220202D */  daddu $a0, $s1, $zero
/* 0FBFD8 802D7628 0C0B210B */  jal   func_802C842C
/* 0FBFDC 802D762C 46000586 */   mov.s $f22, $f0
/* 0FBFE0 802D7630 0220202D */  daddu $a0, $s1, $zero
/* 0FBFE4 802D7634 8E050000 */  lw    $a1, ($s0)
/* 0FBFE8 802D7638 0C0B1EAF */  jal   func_802C7ABC
/* 0FBFEC 802D763C 46000506 */   mov.s $f20, $f0
/* 0FBFF0 802D7640 0040382D */  daddu $a3, $v0, $zero
/* 0FBFF4 802D7644 4600C306 */  mov.s $f12, $f24
/* 0FBFF8 802D7648 4406A000 */  mfc1  $a2, $f20
/* 0FBFFC 802D764C 0C0B5D30 */  jal   func_802D74C0
/* 0FC000 802D7650 4600B386 */   mov.s $f14, $f22
/* 0FC004 802D7654 24040378 */  addiu $a0, $zero, 0x378
/* 0FC008 802D7658 4406C000 */  mfc1  $a2, $f24
/* 0FC00C 802D765C 4407B000 */  mfc1  $a3, $f22
/* 0FC010 802D7660 0000282D */  daddu $a1, $zero, $zero
/* 0FC014 802D7664 0C052757 */  jal   func_80149D5C
/* 0FC018 802D7668 E7B40010 */   swc1  $f20, 0x10($sp)
/* 0FC01C 802D766C 8FBF0020 */  lw    $ra, 0x20($sp)
/* 0FC020 802D7670 8FB1001C */  lw    $s1, 0x1c($sp)
/* 0FC024 802D7674 8FB00018 */  lw    $s0, 0x18($sp)
/* 0FC028 802D7678 D7B80038 */  ldc1  $f24, 0x38($sp)
/* 0FC02C 802D767C D7B60030 */  ldc1  $f22, 0x30($sp)
/* 0FC030 802D7680 D7B40028 */  ldc1  $f20, 0x28($sp)
/* 0FC034 802D7684 24020002 */  addiu $v0, $zero, 2
/* 0FC038 802D7688 03E00008 */  jr    $ra
/* 0FC03C 802D768C 27BD0040 */   addiu $sp, $sp, 0x40

/* 0FC040 802D7690 27BDFFA8 */  addiu $sp, $sp, -0x58
/* 0FC044 802D7694 AFB20020 */  sw    $s2, 0x20($sp)
/* 0FC048 802D7698 0080902D */  daddu $s2, $a0, $zero
/* 0FC04C 802D769C AFB1001C */  sw    $s1, 0x1c($sp)
/* 0FC050 802D76A0 00A0882D */  daddu $s1, $a1, $zero
/* 0FC054 802D76A4 AFBF0024 */  sw    $ra, 0x24($sp)
/* 0FC058 802D76A8 AFB00018 */  sw    $s0, 0x18($sp)
/* 0FC05C 802D76AC F7BE0050 */  sdc1  $f30, 0x50($sp)
/* 0FC060 802D76B0 F7BC0048 */  sdc1  $f28, 0x48($sp)
/* 0FC064 802D76B4 F7BA0040 */  sdc1  $f26, 0x40($sp)
/* 0FC068 802D76B8 F7B80038 */  sdc1  $f24, 0x38($sp)
/* 0FC06C 802D76BC F7B60030 */  sdc1  $f22, 0x30($sp)
/* 0FC070 802D76C0 F7B40028 */  sdc1  $f20, 0x28($sp)
/* 0FC074 802D76C4 8E50000C */  lw    $s0, 0xc($s2)
/* 0FC078 802D76C8 8E050000 */  lw    $a1, ($s0)
/* 0FC07C 802D76CC 0C0B210B */  jal   func_802C842C
/* 0FC080 802D76D0 26100004 */   addiu $s0, $s0, 4
/* 0FC084 802D76D4 8E050000 */  lw    $a1, ($s0)
/* 0FC088 802D76D8 26100004 */  addiu $s0, $s0, 4
/* 0FC08C 802D76DC 0240202D */  daddu $a0, $s2, $zero
/* 0FC090 802D76E0 0C0B210B */  jal   func_802C842C
/* 0FC094 802D76E4 E7A00010 */   swc1  $f0, 0x10($sp)
/* 0FC098 802D76E8 8E050000 */  lw    $a1, ($s0)
/* 0FC09C 802D76EC 26100004 */  addiu $s0, $s0, 4
/* 0FC0A0 802D76F0 0240202D */  daddu $a0, $s2, $zero
/* 0FC0A4 802D76F4 0C0B210B */  jal   func_802C842C
/* 0FC0A8 802D76F8 46000786 */   mov.s $f30, $f0
/* 0FC0AC 802D76FC 8E050000 */  lw    $a1, ($s0)
/* 0FC0B0 802D7700 26100004 */  addiu $s0, $s0, 4
/* 0FC0B4 802D7704 0240202D */  daddu $a0, $s2, $zero
/* 0FC0B8 802D7708 0C0B210B */  jal   func_802C842C
/* 0FC0BC 802D770C E7A00014 */   swc1  $f0, 0x14($sp)
/* 0FC0C0 802D7710 8E050000 */  lw    $a1, ($s0)
/* 0FC0C4 802D7714 26100004 */  addiu $s0, $s0, 4
/* 0FC0C8 802D7718 0240202D */  daddu $a0, $s2, $zero
/* 0FC0CC 802D771C 0C0B210B */  jal   func_802C842C
/* 0FC0D0 802D7720 46000586 */   mov.s $f22, $f0
/* 0FC0D4 802D7724 0240202D */  daddu $a0, $s2, $zero
/* 0FC0D8 802D7728 8E050000 */  lw    $a1, ($s0)
/* 0FC0DC 802D772C 0C0B1EAF */  jal   func_802C7ABC
/* 0FC0E0 802D7730 46000706 */   mov.s $f28, $f0
/* 0FC0E4 802D7734 12200002 */  beqz  $s1, .L802D7740
/* 0FC0E8 802D7738 0040802D */   daddu $s0, $v0, $zero
/* 0FC0EC 802D773C AE400070 */  sw    $zero, 0x70($s2)
.L802D7740:
/* 0FC0F0 802D7740 0C00A67F */  jal   func_800299FC
/* 0FC0F4 802D7744 2404000A */   addiu $a0, $zero, 0xa
/* 0FC0F8 802D7748 2442FFFB */  addiu $v0, $v0, -5
/* 0FC0FC 802D774C 4482D000 */  mtc1  $v0, $f26
/* 0FC100 802D7750 00000000 */  nop   
/* 0FC104 802D7754 4680D6A0 */  cvt.s.w $f26, $f26
/* 0FC108 802D7758 0C00A67F */  jal   func_800299FC
/* 0FC10C 802D775C 2404000A */   addiu $a0, $zero, 0xa
/* 0FC110 802D7760 461AD082 */  mul.s $f2, $f26, $f26
/* 0FC114 802D7764 00000000 */  nop   
/* 0FC118 802D7768 2442FFFB */  addiu $v0, $v0, -5
/* 0FC11C 802D776C 4482C000 */  mtc1  $v0, $f24
/* 0FC120 802D7770 00000000 */  nop   
/* 0FC124 802D7774 4680C620 */  cvt.s.w $f24, $f24
/* 0FC128 802D7778 4618C102 */  mul.s $f4, $f24, $f24
/* 0FC12C 802D777C 00000000 */  nop   
/* 0FC130 802D7780 3C0140C9 */  lui   $at, 0x40c9
/* 0FC134 802D7784 34210FD0 */  ori   $at, $at, 0xfd0
/* 0FC138 802D7788 4481A000 */  mtc1  $at, $f20
/* 0FC13C 802D778C 00000000 */  nop   
/* 0FC140 802D7790 4614B502 */  mul.s $f20, $f22, $f20
/* 0FC144 802D7794 00000000 */  nop   
/* 0FC148 802D7798 3C0143B4 */  lui   $at, 0x43b4
/* 0FC14C 802D779C 44810000 */  mtc1  $at, $f0
/* 0FC150 802D77A0 3C01C000 */  lui   $at, 0xc000
/* 0FC154 802D77A4 4481B000 */  mtc1  $at, $f22
/* 0FC158 802D77A8 46041080 */  add.s $f2, $f2, $f4
/* 0FC15C 802D77AC 4600A503 */  div.s $f20, $f20, $f0
/* 0FC160 802D77B0 3C0140A0 */  lui   $at, 0x40a0
/* 0FC164 802D77B4 44810000 */  mtc1  $at, $f0
/* 0FC168 802D77B8 4600A306 */  mov.s $f12, $f20
/* 0FC16C 802D77BC 46001083 */  div.s $f2, $f2, $f0
/* 0FC170 802D77C0 0C00A85B */  jal   func_8002A16C
/* 0FC174 802D77C4 4602B581 */   sub.s $f22, $f22, $f2
/* 0FC178 802D77C8 4600A306 */  mov.s $f12, $f20
/* 0FC17C 802D77CC 0C00A874 */  jal   func_8002A1D0
/* 0FC180 802D77D0 46000506 */   mov.s $f20, $f0
/* 0FC184 802D77D4 461CA502 */  mul.s $f20, $f20, $f28
/* 0FC188 802D77D8 00000000 */  nop   
/* 0FC18C 802D77DC 46000007 */  neg.s $f0, $f0
/* 0FC190 802D77E0 461C0002 */  mul.s $f0, $f0, $f28
/* 0FC194 802D77E4 00000000 */  nop   
/* 0FC198 802D77E8 C6420070 */  lwc1  $f2, 0x70($s2)
/* 0FC19C 802D77EC 468010A0 */  cvt.s.w $f2, $f2
/* 0FC1A0 802D77F0 4602A502 */  mul.s $f20, $f20, $f2
/* 0FC1A4 802D77F4 00000000 */  nop   
/* 0FC1A8 802D77F8 46020002 */  mul.s $f0, $f0, $f2
/* 0FC1AC 802D77FC 00000000 */  nop   
/* 0FC1B0 802D7800 3C014178 */  lui   $at, 0x4178
/* 0FC1B4 802D7804 44811000 */  mtc1  $at, $f2
/* 0FC1B8 802D7808 00000000 */  nop   
/* 0FC1BC 802D780C 4602F080 */  add.s $f2, $f30, $f2
/* 0FC1C0 802D7810 46161080 */  add.s $f2, $f2, $f22
/* 0FC1C4 802D7814 C7A60010 */  lwc1  $f6, 0x10($sp)
/* 0FC1C8 802D7818 44051000 */  mfc1  $a1, $f2
/* 0FC1CC 802D781C 44901000 */  mtc1  $s0, $f2
/* 0FC1D0 802D7820 00000000 */  nop   
/* 0FC1D4 802D7824 468010A0 */  cvt.s.w $f2, $f2
/* 0FC1D8 802D7828 4602A503 */  div.s $f20, $f20, $f2
/* 0FC1DC 802D782C 46143500 */  add.s $f20, $f6, $f20
/* 0FC1E0 802D7830 C7A60014 */  lwc1  $f6, 0x14($sp)
/* 0FC1E4 802D7834 46020003 */  div.s $f0, $f0, $f2
/* 0FC1E8 802D7838 46003000 */  add.s $f0, $f6, $f0
/* 0FC1EC 802D783C 46180000 */  add.s $f0, $f0, $f24
/* 0FC1F0 802D7840 461AA500 */  add.s $f20, $f20, $f26
/* 0FC1F4 802D7844 44060000 */  mfc1  $a2, $f0
/* 0FC1F8 802D7848 4600A18D */  trunc.w.s $f6, $f20
/* 0FC1FC 802D784C 44043000 */  mfc1  $a0, $f6
/* 0FC200 802D7850 0C01BF2C */  jal   func_8006FCB0
/* 0FC204 802D7854 0000382D */   daddu $a3, $zero, $zero
/* 0FC208 802D7858 8E430070 */  lw    $v1, 0x70($s2)
/* 0FC20C 802D785C 24630001 */  addiu $v1, $v1, 1
/* 0FC210 802D7860 0070102A */  slt   $v0, $v1, $s0
/* 0FC214 802D7864 38420001 */  xori  $v0, $v0, 1
/* 0FC218 802D7868 AE430070 */  sw    $v1, 0x70($s2)
/* 0FC21C 802D786C 8FBF0024 */  lw    $ra, 0x24($sp)
/* 0FC220 802D7870 8FB20020 */  lw    $s2, 0x20($sp)
/* 0FC224 802D7874 8FB1001C */  lw    $s1, 0x1c($sp)
/* 0FC228 802D7878 8FB00018 */  lw    $s0, 0x18($sp)
/* 0FC22C 802D787C D7BE0050 */  ldc1  $f30, 0x50($sp)
/* 0FC230 802D7880 D7BC0048 */  ldc1  $f28, 0x48($sp)
/* 0FC234 802D7884 D7BA0040 */  ldc1  $f26, 0x40($sp)
/* 0FC238 802D7888 D7B80038 */  ldc1  $f24, 0x38($sp)
/* 0FC23C 802D788C D7B60030 */  ldc1  $f22, 0x30($sp)
/* 0FC240 802D7890 D7B40028 */  ldc1  $f20, 0x28($sp)
/* 0FC244 802D7894 00021040 */  sll   $v0, $v0, 1
/* 0FC248 802D7898 03E00008 */  jr    $ra
/* 0FC24C 802D789C 27BD0058 */   addiu $sp, $sp, 0x58

/* 0FC250 802D78A0 27BDFF90 */  addiu $sp, $sp, -0x70
/* 0FC254 802D78A4 AFB10034 */  sw    $s1, 0x34($sp)
/* 0FC258 802D78A8 0080882D */  daddu $s1, $a0, $zero
/* 0FC25C 802D78AC AFBF0048 */  sw    $ra, 0x48($sp)
/* 0FC260 802D78B0 AFB50044 */  sw    $s5, 0x44($sp)
/* 0FC264 802D78B4 AFB40040 */  sw    $s4, 0x40($sp)
/* 0FC268 802D78B8 AFB3003C */  sw    $s3, 0x3c($sp)
/* 0FC26C 802D78BC AFB20038 */  sw    $s2, 0x38($sp)
/* 0FC270 802D78C0 AFB00030 */  sw    $s0, 0x30($sp)
/* 0FC274 802D78C4 F7BA0068 */  sdc1  $f26, 0x68($sp)
/* 0FC278 802D78C8 F7B80060 */  sdc1  $f24, 0x60($sp)
/* 0FC27C 802D78CC F7B60058 */  sdc1  $f22, 0x58($sp)
/* 0FC280 802D78D0 F7B40050 */  sdc1  $f20, 0x50($sp)
/* 0FC284 802D78D4 8E30000C */  lw    $s0, 0xc($s1)
/* 0FC288 802D78D8 8E050000 */  lw    $a1, ($s0)
/* 0FC28C 802D78DC 0C0B1EAF */  jal   func_802C7ABC
/* 0FC290 802D78E0 26100004 */   addiu $s0, $s0, 4
/* 0FC294 802D78E4 8E050000 */  lw    $a1, ($s0)
/* 0FC298 802D78E8 26100004 */  addiu $s0, $s0, 4
/* 0FC29C 802D78EC 0220202D */  daddu $a0, $s1, $zero
/* 0FC2A0 802D78F0 0C0B1EAF */  jal   func_802C7ABC
/* 0FC2A4 802D78F4 0040982D */   daddu $s3, $v0, $zero
/* 0FC2A8 802D78F8 8E050000 */  lw    $a1, ($s0)
/* 0FC2AC 802D78FC 26100004 */  addiu $s0, $s0, 4
/* 0FC2B0 802D7900 0220202D */  daddu $a0, $s1, $zero
/* 0FC2B4 802D7904 0C0B210B */  jal   func_802C842C
/* 0FC2B8 802D7908 0040A82D */   daddu $s5, $v0, $zero
/* 0FC2BC 802D790C 8E050000 */  lw    $a1, ($s0)
/* 0FC2C0 802D7910 26100004 */  addiu $s0, $s0, 4
/* 0FC2C4 802D7914 0220202D */  daddu $a0, $s1, $zero
/* 0FC2C8 802D7918 0C0B1EAF */  jal   func_802C7ABC
/* 0FC2CC 802D791C 46000686 */   mov.s $f26, $f0
/* 0FC2D0 802D7920 8E050000 */  lw    $a1, ($s0)
/* 0FC2D4 802D7924 26100004 */  addiu $s0, $s0, 4
/* 0FC2D8 802D7928 0220202D */  daddu $a0, $s1, $zero
/* 0FC2DC 802D792C 0C0B1EAF */  jal   func_802C7ABC
/* 0FC2E0 802D7930 0040A02D */   daddu $s4, $v0, $zero
/* 0FC2E4 802D7934 8E050000 */  lw    $a1, ($s0)
/* 0FC2E8 802D7938 26100004 */  addiu $s0, $s0, 4
/* 0FC2EC 802D793C 0220202D */  daddu $a0, $s1, $zero
/* 0FC2F0 802D7940 0C0B210B */  jal   func_802C842C
/* 0FC2F4 802D7944 0040902D */   daddu $s2, $v0, $zero
/* 0FC2F8 802D7948 8E050000 */  lw    $a1, ($s0)
/* 0FC2FC 802D794C 26100004 */  addiu $s0, $s0, 4
/* 0FC300 802D7950 0220202D */  daddu $a0, $s1, $zero
/* 0FC304 802D7954 0C0B210B */  jal   func_802C842C
/* 0FC308 802D7958 46000606 */   mov.s $f24, $f0
/* 0FC30C 802D795C 8E050000 */  lw    $a1, ($s0)
/* 0FC310 802D7960 26100004 */  addiu $s0, $s0, 4
/* 0FC314 802D7964 0220202D */  daddu $a0, $s1, $zero
/* 0FC318 802D7968 0C0B210B */  jal   func_802C842C
/* 0FC31C 802D796C 46000586 */   mov.s $f22, $f0
/* 0FC320 802D7970 0220202D */  daddu $a0, $s1, $zero
/* 0FC324 802D7974 8E050000 */  lw    $a1, ($s0)
/* 0FC328 802D7978 0C0B210B */  jal   func_802C842C
/* 0FC32C 802D797C 46000506 */   mov.s $f20, $f0
/* 0FC330 802D7980 12400006 */  beqz  $s2, .L802D799C
/* 0FC334 802D7984 3C055555 */   lui   $a1, 0x5555
/* 0FC338 802D7988 24020001 */  addiu $v0, $zero, 1
/* 0FC33C 802D798C 12420018 */  beq   $s2, $v0, .L802D79F0
/* 0FC340 802D7990 4600C086 */   mov.s $f2, $f24
/* 0FC344 802D7994 080B5E9E */  j     func_802D7A78
/* 0FC348 802D7998 4600B106 */   mov.s $f4, $f22

.L802D799C:
/* 0FC34C 802D799C 3C028011 */  lui   $v0, 0x8011
/* 0FC350 802D79A0 9442F078 */  lhu   $v0, -0xf88($v0)
/* 0FC354 802D79A4 34A55556 */  ori   $a1, $a1, 0x5556
/* 0FC358 802D79A8 00021400 */  sll   $v0, $v0, 0x10
/* 0FC35C 802D79AC 00022403 */  sra   $a0, $v0, 0x10
/* 0FC360 802D79B0 00041840 */  sll   $v1, $a0, 1
/* 0FC364 802D79B4 00650018 */  mult  $v1, $a1
/* 0FC368 802D79B8 44801000 */  mtc1  $zero, $f2
/* 0FC36C 802D79BC 00003010 */  mfhi  $a2
/* 0FC370 802D79C0 2407FFFF */  addiu $a3, $zero, -1
/* 0FC374 802D79C4 46001186 */  mov.s $f6, $f2
/* 0FC378 802D79C8 00850018 */  mult  $a0, $a1
/* 0FC37C 802D79CC 00031FC3 */  sra   $v1, $v1, 0x1f
/* 0FC380 802D79D0 000217C3 */  sra   $v0, $v0, 0x1f
/* 0FC384 802D79D4 00C31823 */  subu  $v1, $a2, $v1
/* 0FC388 802D79D8 44832000 */  mtc1  $v1, $f4
/* 0FC38C 802D79DC 00000000 */  nop   
/* 0FC390 802D79E0 46802120 */  cvt.s.w $f4, $f4
/* 0FC394 802D79E4 00004810 */  mfhi  $t1
/* 0FC398 802D79E8 080B5E97 */  j     func_802D7A5C
/* 0FC39C 802D79EC 01221023 */   subu  $v0, $t1, $v0

.L802D79F0:
/* 0FC3A0 802D79F0 0220202D */  daddu $a0, $s1, $zero
/* 0FC3A4 802D79F4 0C0B36B0 */  jal   func_802CDAC0
/* 0FC3A8 802D79F8 0260282D */   daddu $a1, $s3, $zero
/* 0FC3AC 802D79FC 0040382D */  daddu $a3, $v0, $zero
/* 0FC3B0 802D7A00 10E0002A */  beqz  $a3, .L802D7AAC
/* 0FC3B4 802D7A04 3C036666 */   lui   $v1, 0x6666
/* 0FC3B8 802D7A08 94E200A8 */  lhu   $v0, 0xa8($a3)
/* 0FC3BC 802D7A0C 34636667 */  ori   $v1, $v1, 0x6667
/* 0FC3C0 802D7A10 00021400 */  sll   $v0, $v0, 0x10
/* 0FC3C4 802D7A14 00023403 */  sra   $a2, $v0, 0x10
/* 0FC3C8 802D7A18 00062080 */  sll   $a0, $a2, 2
/* 0FC3CC 802D7A1C 00830018 */  mult  $a0, $v1
/* 0FC3D0 802D7A20 3C055555 */  lui   $a1, 0x5555
/* 0FC3D4 802D7A24 34A55556 */  ori   $a1, $a1, 0x5556
/* 0FC3D8 802D7A28 44801000 */  mtc1  $zero, $f2
/* 0FC3DC 802D7A2C 00004010 */  mfhi  $t0
/* 0FC3E0 802D7A30 46001186 */  mov.s $f6, $f2
/* 0FC3E4 802D7A34 00081843 */  sra   $v1, $t0, 1
/* 0FC3E8 802D7A38 00C50018 */  mult  $a2, $a1
/* 0FC3EC 802D7A3C 000427C3 */  sra   $a0, $a0, 0x1f
/* 0FC3F0 802D7A40 000217C3 */  sra   $v0, $v0, 0x1f
/* 0FC3F4 802D7A44 00641823 */  subu  $v1, $v1, $a0
/* 0FC3F8 802D7A48 44832000 */  mtc1  $v1, $f4
/* 0FC3FC 802D7A4C 00000000 */  nop   
/* 0FC400 802D7A50 46802120 */  cvt.s.w $f4, $f4
/* 0FC404 802D7A54 00004010 */  mfhi  $t0
/* 0FC408 802D7A58 01021023 */  subu  $v0, $t0, $v0
func_802D7A5C:
/* 0FC40C 802D7A5C 00021400 */  sll   $v0, $v0, 0x10
/* 0FC410 802D7A60 00021403 */  sra   $v0, $v0, 0x10
/* 0FC414 802D7A64 44820000 */  mtc1  $v0, $f0
/* 0FC418 802D7A68 00000000 */  nop   
/* 0FC41C 802D7A6C 46800020 */  cvt.s.w $f0, $f0
/* 0FC420 802D7A70 080B5EA1 */  j     func_802D7A84
/* 0FC424 802D7A74 02A0202D */   daddu $a0, $s5, $zero

func_802D7A78:
/* 0FC428 802D7A78 4600A186 */  mov.s $f6, $f20
/* 0FC42C 802D7A7C 0000382D */  daddu $a3, $zero, $zero
/* 0FC430 802D7A80 02A0202D */  daddu $a0, $s5, $zero
func_802D7A84:
/* 0FC434 802D7A84 00E0282D */  daddu $a1, $a3, $zero
/* 0FC438 802D7A88 44061000 */  mfc1  $a2, $f2
/* 0FC43C 802D7A8C 44072000 */  mfc1  $a3, $f4
/* 0FC440 802D7A90 27A20028 */  addiu $v0, $sp, 0x28
/* 0FC444 802D7A94 E7A60010 */  swc1  $f6, 0x10($sp)
/* 0FC448 802D7A98 E7A00014 */  swc1  $f0, 0x14($sp)
/* 0FC44C 802D7A9C E7BA0018 */  swc1  $f26, 0x18($sp)
/* 0FC450 802D7AA0 AFB4001C */  sw    $s4, 0x1c($sp)
/* 0FC454 802D7AA4 0C01BFA4 */  jal   func_8006FE90
/* 0FC458 802D7AA8 AFA20020 */   sw    $v0, 0x20($sp)
.L802D7AAC:
/* 0FC45C 802D7AAC 24020002 */  addiu $v0, $zero, 2
/* 0FC460 802D7AB0 8FBF0048 */  lw    $ra, 0x48($sp)
/* 0FC464 802D7AB4 8FB50044 */  lw    $s5, 0x44($sp)
/* 0FC468 802D7AB8 8FB40040 */  lw    $s4, 0x40($sp)
/* 0FC46C 802D7ABC 8FB3003C */  lw    $s3, 0x3c($sp)
/* 0FC470 802D7AC0 8FB20038 */  lw    $s2, 0x38($sp)
/* 0FC474 802D7AC4 8FB10034 */  lw    $s1, 0x34($sp)
/* 0FC478 802D7AC8 8FB00030 */  lw    $s0, 0x30($sp)
/* 0FC47C 802D7ACC D7BA0068 */  ldc1  $f26, 0x68($sp)
/* 0FC480 802D7AD0 D7B80060 */  ldc1  $f24, 0x60($sp)
/* 0FC484 802D7AD4 D7B60058 */  ldc1  $f22, 0x58($sp)
/* 0FC488 802D7AD8 D7B40050 */  ldc1  $f20, 0x50($sp)
/* 0FC48C 802D7ADC 03E00008 */  jr    $ra
/* 0FC490 802D7AE0 27BD0070 */   addiu $sp, $sp, 0x70

/* 0FC494 802D7AE4 27BDFFE8 */  addiu $sp, $sp, -0x18
/* 0FC498 802D7AE8 AFBF0010 */  sw    $ra, 0x10($sp)
/* 0FC49C 802D7AEC 8C82000C */  lw    $v0, 0xc($a0)
/* 0FC4A0 802D7AF0 0C0B1EAF */  jal   func_802C7ABC
/* 0FC4A4 802D7AF4 8C450000 */   lw    $a1, ($v0)
/* 0FC4A8 802D7AF8 0C016914 */  jal   func_8005A450
/* 0FC4AC 802D7AFC 0040202D */   daddu $a0, $v0, $zero
/* 0FC4B0 802D7B00 8FBF0010 */  lw    $ra, 0x10($sp)
/* 0FC4B4 802D7B04 24020002 */  addiu $v0, $zero, 2
/* 0FC4B8 802D7B08 03E00008 */  jr    $ra
/* 0FC4BC 802D7B0C 27BD0018 */   addiu $sp, $sp, 0x18

/* 0FC4C0 802D7B10 27BDFFE8 */  addiu $sp, $sp, -0x18
/* 0FC4C4 802D7B14 AFBF0010 */  sw    $ra, 0x10($sp)
/* 0FC4C8 802D7B18 8C82000C */  lw    $v0, 0xc($a0)
/* 0FC4CC 802D7B1C 0C0B1EAF */  jal   func_802C7ABC
/* 0FC4D0 802D7B20 8C450000 */   lw    $a1, ($v0)
/* 0FC4D4 802D7B24 0040202D */  daddu $a0, $v0, $zero
/* 0FC4D8 802D7B28 8C830000 */  lw    $v1, ($a0)
/* 0FC4DC 802D7B2C 34630010 */  ori   $v1, $v1, 0x10
/* 0FC4E0 802D7B30 AC830000 */  sw    $v1, ($a0)
/* 0FC4E4 802D7B34 8FBF0010 */  lw    $ra, 0x10($sp)
/* 0FC4E8 802D7B38 24020002 */  addiu $v0, $zero, 2
/* 0FC4EC 802D7B3C 03E00008 */  jr    $ra
/* 0FC4F0 802D7B40 27BD0018 */   addiu $sp, $sp, 0x18

/* 0FC4F4 802D7B44 27BDFFE8 */  addiu $sp, $sp, -0x18
/* 0FC4F8 802D7B48 AFBF0010 */  sw    $ra, 0x10($sp)
/* 0FC4FC 802D7B4C 8C82000C */  lw    $v0, 0xc($a0)
/* 0FC500 802D7B50 0C0B1EAF */  jal   func_802C7ABC
/* 0FC504 802D7B54 8C450000 */   lw    $a1, ($v0)
/* 0FC508 802D7B58 8C44000C */  lw    $a0, 0xc($v0)
/* 0FC50C 802D7B5C 2403000A */  addiu $v1, $zero, 0xa
/* 0FC510 802D7B60 AC830014 */  sw    $v1, 0x14($a0)
/* 0FC514 802D7B64 8FBF0010 */  lw    $ra, 0x10($sp)
/* 0FC518 802D7B68 24020002 */  addiu $v0, $zero, 2
/* 0FC51C 802D7B6C 03E00008 */  jr    $ra
/* 0FC520 802D7B70 27BD0018 */   addiu $sp, $sp, 0x18

/* 0FC524 802D7B74 27BDFFE8 */  addiu $sp, $sp, -0x18
/* 0FC528 802D7B78 AFBF0010 */  sw    $ra, 0x10($sp)
/* 0FC52C 802D7B7C 8C82000C */  lw    $v0, 0xc($a0)
/* 0FC530 802D7B80 0C0B1EAF */  jal   func_802C7ABC
/* 0FC534 802D7B84 8C450000 */   lw    $a1, ($v0)
/* 0FC538 802D7B88 8C44000C */  lw    $a0, 0xc($v0)
/* 0FC53C 802D7B8C 24030005 */  addiu $v1, $zero, 5
/* 0FC540 802D7B90 AC830030 */  sw    $v1, 0x30($a0)
/* 0FC544 802D7B94 8FBF0010 */  lw    $ra, 0x10($sp)
/* 0FC548 802D7B98 24020002 */  addiu $v0, $zero, 2
/* 0FC54C 802D7B9C 03E00008 */  jr    $ra
/* 0FC550 802D7BA0 27BD0018 */   addiu $sp, $sp, 0x18

/* 0FC554 802D7BA4 27BDFFC8 */  addiu $sp, $sp, -0x38
/* 0FC558 802D7BA8 AFB00018 */  sw    $s0, 0x18($sp)
/* 0FC55C 802D7BAC 0080802D */  daddu $s0, $a0, $zero
/* 0FC560 802D7BB0 AFBF0034 */  sw    $ra, 0x34($sp)
/* 0FC564 802D7BB4 AFB60030 */  sw    $s6, 0x30($sp)
/* 0FC568 802D7BB8 AFB5002C */  sw    $s5, 0x2c($sp)
/* 0FC56C 802D7BBC AFB40028 */  sw    $s4, 0x28($sp)
/* 0FC570 802D7BC0 AFB30024 */  sw    $s3, 0x24($sp)
/* 0FC574 802D7BC4 AFB20020 */  sw    $s2, 0x20($sp)
/* 0FC578 802D7BC8 AFB1001C */  sw    $s1, 0x1c($sp)
/* 0FC57C 802D7BCC 8E130088 */  lw    $s3, 0x88($s0)
/* 0FC580 802D7BD0 8E14008C */  lw    $s4, 0x8c($s0)
/* 0FC584 802D7BD4 8E150090 */  lw    $s5, 0x90($s0)
/* 0FC588 802D7BD8 8E160094 */  lw    $s6, 0x94($s0)
/* 0FC58C 802D7BDC 8E120098 */  lw    $s2, 0x98($s0)
/* 0FC590 802D7BE0 8E11009C */  lw    $s1, 0x9c($s0)
/* 0FC594 802D7BE4 10A00012 */  beqz  $a1, .L802D7C30
/* 0FC598 802D7BE8 27A50010 */   addiu $a1, $sp, 0x10
/* 0FC59C 802D7BEC 24040001 */  addiu $a0, $zero, 1
/* 0FC5A0 802D7BF0 27A60014 */  addiu $a2, $sp, 0x14
/* 0FC5A4 802D7BF4 0C04DF70 */  jal   func_80137DC0
/* 0FC5A8 802D7BF8 AE110070 */   sw    $s1, 0x70($s0)
/* 0FC5AC 802D7BFC 24040001 */  addiu $a0, $zero, 1
/* 0FC5B0 802D7C00 0000282D */  daddu $a1, $zero, $zero
/* 0FC5B4 802D7C04 0260302D */  daddu $a2, $s3, $zero
/* 0FC5B8 802D7C08 C7A00014 */  lwc1  $f0, 0x14($sp)
/* 0FC5BC 802D7C0C 4600008D */  trunc.w.s $f2, $f0
/* 0FC5C0 802D7C10 E6020074 */  swc1  $f2, 0x74($s0)
/* 0FC5C4 802D7C14 0C04DF93 */  jal   func_80137E4C
/* 0FC5C8 802D7C18 0280382D */   daddu $a3, $s4, $zero
/* 0FC5CC 802D7C1C 24040001 */  addiu $a0, $zero, 1
/* 0FC5D0 802D7C20 0080282D */  daddu $a1, $a0, $zero
/* 0FC5D4 802D7C24 02A0302D */  daddu $a2, $s5, $zero
/* 0FC5D8 802D7C28 0C04DF93 */  jal   func_80137E4C
/* 0FC5DC 802D7C2C 02C0382D */   daddu $a3, $s6, $zero
.L802D7C30:
/* 0FC5E0 802D7C30 24040001 */  addiu $a0, $zero, 1
/* 0FC5E4 802D7C34 27A50010 */  addiu $a1, $sp, 0x10
/* 0FC5E8 802D7C38 0C04DF70 */  jal   func_80137DC0
/* 0FC5EC 802D7C3C 27A60014 */   addiu $a2, $sp, 0x14
/* 0FC5F0 802D7C40 8E020074 */  lw    $v0, 0x74($s0)
/* 0FC5F4 802D7C44 8E030070 */  lw    $v1, 0x70($s0)
/* 0FC5F8 802D7C48 00521023 */  subu  $v0, $v0, $s2
/* 0FC5FC 802D7C4C 00430018 */  mult  $v0, $v1
/* 0FC600 802D7C50 00001812 */  mflo  $v1
/* 0FC604 802D7C54 00000000 */  nop   
/* 0FC608 802D7C58 16200002 */  bnez  $s1, .L802D7C64
/* 0FC60C 802D7C5C 0071001A */   div   $zero, $v1, $s1
/* 0FC610 802D7C60 0007000D */  break 7
.L802D7C64:
/* 0FC614 802D7C64 2401FFFF */  addiu $at, $zero, -1
/* 0FC618 802D7C68 16210004 */  bne   $s1, $at, .L802D7C7C
/* 0FC61C 802D7C6C 3C018000 */   lui   $at, 0x8000
/* 0FC620 802D7C70 14610002 */  bne   $v1, $at, .L802D7C7C
/* 0FC624 802D7C74 00000000 */   nop   
/* 0FC628 802D7C78 0006000D */  break 6
.L802D7C7C:
/* 0FC62C 802D7C7C 00001012 */  mflo  $v0
/* 0FC630 802D7C80 00521021 */  addu  $v0, $v0, $s2
/* 0FC634 802D7C84 44821000 */  mtc1  $v0, $f2
/* 0FC638 802D7C88 00000000 */  nop   
/* 0FC63C 802D7C8C 468010A0 */  cvt.s.w $f2, $f2
/* 0FC640 802D7C90 44051000 */  mfc1  $a1, $f2
/* 0FC644 802D7C94 0C04DF69 */  jal   func_80137DA4
/* 0FC648 802D7C98 2404000C */   addiu $a0, $zero, 0xc
/* 0FC64C 802D7C9C 8E020070 */  lw    $v0, 0x70($s0)
/* 0FC650 802D7CA0 2442FFFF */  addiu $v0, $v0, -1
/* 0FC654 802D7CA4 04400003 */  bltz  $v0, .L802D7CB4
/* 0FC658 802D7CA8 AE020070 */   sw    $v0, 0x70($s0)
/* 0FC65C 802D7CAC 080B5F34 */  j     func_802D7CD0
/* 0FC660 802D7CB0 0000102D */   daddu $v0, $zero, $zero

.L802D7CB4:
/* 0FC664 802D7CB4 44921000 */  mtc1  $s2, $f2
/* 0FC668 802D7CB8 00000000 */  nop   
/* 0FC66C 802D7CBC 468010A0 */  cvt.s.w $f2, $f2
/* 0FC670 802D7CC0 44051000 */  mfc1  $a1, $f2
/* 0FC674 802D7CC4 0C04DF69 */  jal   func_80137DA4
/* 0FC678 802D7CC8 2404000C */   addiu $a0, $zero, 0xc
/* 0FC67C 802D7CCC 24020002 */  addiu $v0, $zero, 2
func_802D7CD0:
/* 0FC680 802D7CD0 8FBF0034 */  lw    $ra, 0x34($sp)
/* 0FC684 802D7CD4 8FB60030 */  lw    $s6, 0x30($sp)
/* 0FC688 802D7CD8 8FB5002C */  lw    $s5, 0x2c($sp)
/* 0FC68C 802D7CDC 8FB40028 */  lw    $s4, 0x28($sp)
/* 0FC690 802D7CE0 8FB30024 */  lw    $s3, 0x24($sp)
/* 0FC694 802D7CE4 8FB20020 */  lw    $s2, 0x20($sp)
/* 0FC698 802D7CE8 8FB1001C */  lw    $s1, 0x1c($sp)
/* 0FC69C 802D7CEC 8FB00018 */  lw    $s0, 0x18($sp)
/* 0FC6A0 802D7CF0 03E00008 */  jr    $ra
/* 0FC6A4 802D7CF4 27BD0038 */   addiu $sp, $sp, 0x38

/* 0FC6A8 802D7CF8 27BDFFD0 */  addiu $sp, $sp, -0x30
/* 0FC6AC 802D7CFC AFB10014 */  sw    $s1, 0x14($sp)
/* 0FC6B0 802D7D00 0080882D */  daddu $s1, $a0, $zero
/* 0FC6B4 802D7D04 AFBF002C */  sw    $ra, 0x2c($sp)
/* 0FC6B8 802D7D08 AFB60028 */  sw    $s6, 0x28($sp)
/* 0FC6BC 802D7D0C AFB50024 */  sw    $s5, 0x24($sp)
/* 0FC6C0 802D7D10 AFB40020 */  sw    $s4, 0x20($sp)
/* 0FC6C4 802D7D14 AFB3001C */  sw    $s3, 0x1c($sp)
/* 0FC6C8 802D7D18 AFB20018 */  sw    $s2, 0x18($sp)
/* 0FC6CC 802D7D1C AFB00010 */  sw    $s0, 0x10($sp)
/* 0FC6D0 802D7D20 8E30000C */  lw    $s0, 0xc($s1)
/* 0FC6D4 802D7D24 8E050000 */  lw    $a1, ($s0)
/* 0FC6D8 802D7D28 0C0B1EAF */  jal   func_802C7ABC
/* 0FC6DC 802D7D2C 26100004 */   addiu $s0, $s0, 4
/* 0FC6E0 802D7D30 8E050000 */  lw    $a1, ($s0)
/* 0FC6E4 802D7D34 26100004 */  addiu $s0, $s0, 4
/* 0FC6E8 802D7D38 0220202D */  daddu $a0, $s1, $zero
/* 0FC6EC 802D7D3C 0C0B1EAF */  jal   func_802C7ABC
/* 0FC6F0 802D7D40 0040B02D */   daddu $s6, $v0, $zero
/* 0FC6F4 802D7D44 8E050000 */  lw    $a1, ($s0)
/* 0FC6F8 802D7D48 26100004 */  addiu $s0, $s0, 4
/* 0FC6FC 802D7D4C 0220202D */  daddu $a0, $s1, $zero
/* 0FC700 802D7D50 0C0B1EAF */  jal   func_802C7ABC
/* 0FC704 802D7D54 0040A82D */   daddu $s5, $v0, $zero
/* 0FC708 802D7D58 8E050000 */  lw    $a1, ($s0)
/* 0FC70C 802D7D5C 26100004 */  addiu $s0, $s0, 4
/* 0FC710 802D7D60 0220202D */  daddu $a0, $s1, $zero
/* 0FC714 802D7D64 0C0B1EAF */  jal   func_802C7ABC
/* 0FC718 802D7D68 0040A02D */   daddu $s4, $v0, $zero
/* 0FC71C 802D7D6C 8E050000 */  lw    $a1, ($s0)
/* 0FC720 802D7D70 26100004 */  addiu $s0, $s0, 4
/* 0FC724 802D7D74 0220202D */  daddu $a0, $s1, $zero
/* 0FC728 802D7D78 0C0B1EAF */  jal   func_802C7ABC
/* 0FC72C 802D7D7C 0040982D */   daddu $s3, $v0, $zero
/* 0FC730 802D7D80 8E050000 */  lw    $a1, ($s0)
/* 0FC734 802D7D84 26100004 */  addiu $s0, $s0, 4
/* 0FC738 802D7D88 0220202D */  daddu $a0, $s1, $zero
/* 0FC73C 802D7D8C 0C0B1EAF */  jal   func_802C7ABC
/* 0FC740 802D7D90 0040902D */   daddu $s2, $v0, $zero
/* 0FC744 802D7D94 0220202D */  daddu $a0, $s1, $zero
/* 0FC748 802D7D98 8E050000 */  lw    $a1, ($s0)
/* 0FC74C 802D7D9C 0C0B1EAF */  jal   func_802C7ABC
/* 0FC750 802D7DA0 0040882D */   daddu $s1, $v0, $zero
/* 0FC754 802D7DA4 3C04802E */  lui   $a0, 0x802e
/* 0FC758 802D7DA8 24849D50 */  addiu $a0, $a0, -0x62b0
/* 0FC75C 802D7DAC 24050001 */  addiu $a1, $zero, 1
/* 0FC760 802D7DB0 0040802D */  daddu $s0, $v0, $zero
/* 0FC764 802D7DB4 0C0B0CF8 */  jal   func_802C33E0
/* 0FC768 802D7DB8 0000302D */   daddu $a2, $zero, $zero
/* 0FC76C 802D7DBC 0040182D */  daddu $v1, $v0, $zero
/* 0FC770 802D7DC0 AC760084 */  sw    $s6, 0x84($v1)
/* 0FC774 802D7DC4 AC750088 */  sw    $s5, 0x88($v1)
/* 0FC778 802D7DC8 AC74008C */  sw    $s4, 0x8c($v1)
/* 0FC77C 802D7DCC AC730090 */  sw    $s3, 0x90($v1)
/* 0FC780 802D7DD0 AC720094 */  sw    $s2, 0x94($v1)
/* 0FC784 802D7DD4 AC710098 */  sw    $s1, 0x98($v1)
/* 0FC788 802D7DD8 AC70009C */  sw    $s0, 0x9c($v1)
/* 0FC78C 802D7DDC 8FBF002C */  lw    $ra, 0x2c($sp)
/* 0FC790 802D7DE0 8FB60028 */  lw    $s6, 0x28($sp)
/* 0FC794 802D7DE4 8FB50024 */  lw    $s5, 0x24($sp)
/* 0FC798 802D7DE8 8FB40020 */  lw    $s4, 0x20($sp)
/* 0FC79C 802D7DEC 8FB3001C */  lw    $s3, 0x1c($sp)
/* 0FC7A0 802D7DF0 8FB20018 */  lw    $s2, 0x18($sp)
/* 0FC7A4 802D7DF4 8FB10014 */  lw    $s1, 0x14($sp)
/* 0FC7A8 802D7DF8 8FB00010 */  lw    $s0, 0x10($sp)
/* 0FC7AC 802D7DFC 24020002 */  addiu $v0, $zero, 2
/* 0FC7B0 802D7E00 03E00008 */  jr    $ra
/* 0FC7B4 802D7E04 27BD0030 */   addiu $sp, $sp, 0x30

/* 0FC7B8 802D7E08 27BDFFA0 */  addiu $sp, $sp, -0x60
/* 0FC7BC 802D7E0C AFB10024 */  sw    $s1, 0x24($sp)
/* 0FC7C0 802D7E10 0080882D */  daddu $s1, $a0, $zero
/* 0FC7C4 802D7E14 AFBF0034 */  sw    $ra, 0x34($sp)
/* 0FC7C8 802D7E18 AFB40030 */  sw    $s4, 0x30($sp)
/* 0FC7CC 802D7E1C AFB3002C */  sw    $s3, 0x2c($sp)
/* 0FC7D0 802D7E20 AFB20028 */  sw    $s2, 0x28($sp)
/* 0FC7D4 802D7E24 AFB00020 */  sw    $s0, 0x20($sp)
/* 0FC7D8 802D7E28 F7BC0058 */  sdc1  $f28, 0x58($sp)
/* 0FC7DC 802D7E2C F7BA0050 */  sdc1  $f26, 0x50($sp)
/* 0FC7E0 802D7E30 F7B80048 */  sdc1  $f24, 0x48($sp)
/* 0FC7E4 802D7E34 F7B60040 */  sdc1  $f22, 0x40($sp)
/* 0FC7E8 802D7E38 F7B40038 */  sdc1  $f20, 0x38($sp)
/* 0FC7EC 802D7E3C 8E30000C */  lw    $s0, 0xc($s1)
/* 0FC7F0 802D7E40 8E050000 */  lw    $a1, ($s0)
/* 0FC7F4 802D7E44 0C0B1EAF */  jal   func_802C7ABC
/* 0FC7F8 802D7E48 26100004 */   addiu $s0, $s0, 4
/* 0FC7FC 802D7E4C 8E050000 */  lw    $a1, ($s0)
/* 0FC800 802D7E50 26100004 */  addiu $s0, $s0, 4
/* 0FC804 802D7E54 0220202D */  daddu $a0, $s1, $zero
/* 0FC808 802D7E58 0C0B1EAF */  jal   func_802C7ABC
/* 0FC80C 802D7E5C 0040982D */   daddu $s3, $v0, $zero
/* 0FC810 802D7E60 8E050000 */  lw    $a1, ($s0)
/* 0FC814 802D7E64 26100004 */  addiu $s0, $s0, 4
/* 0FC818 802D7E68 0220202D */  daddu $a0, $s1, $zero
/* 0FC81C 802D7E6C 0C0B210B */  jal   func_802C842C
/* 0FC820 802D7E70 0040A02D */   daddu $s4, $v0, $zero
/* 0FC824 802D7E74 8E050000 */  lw    $a1, ($s0)
/* 0FC828 802D7E78 26100004 */  addiu $s0, $s0, 4
/* 0FC82C 802D7E7C 0220202D */  daddu $a0, $s1, $zero
/* 0FC830 802D7E80 0C0B1EAF */  jal   func_802C7ABC
/* 0FC834 802D7E84 46000706 */   mov.s $f28, $f0
/* 0FC838 802D7E88 8E050000 */  lw    $a1, ($s0)
/* 0FC83C 802D7E8C 26100004 */  addiu $s0, $s0, 4
/* 0FC840 802D7E90 0220202D */  daddu $a0, $s1, $zero
/* 0FC844 802D7E94 0C0B210B */  jal   func_802C842C
/* 0FC848 802D7E98 0040902D */   daddu $s2, $v0, $zero
/* 0FC84C 802D7E9C 8E050000 */  lw    $a1, ($s0)
/* 0FC850 802D7EA0 26100004 */  addiu $s0, $s0, 4
/* 0FC854 802D7EA4 0220202D */  daddu $a0, $s1, $zero
/* 0FC858 802D7EA8 0C0B210B */  jal   func_802C842C
/* 0FC85C 802D7EAC 46000686 */   mov.s $f26, $f0
/* 0FC860 802D7EB0 8E050000 */  lw    $a1, ($s0)
/* 0FC864 802D7EB4 26100004 */  addiu $s0, $s0, 4
/* 0FC868 802D7EB8 0220202D */  daddu $a0, $s1, $zero
/* 0FC86C 802D7EBC 0C0B210B */  jal   func_802C842C
/* 0FC870 802D7EC0 46000606 */   mov.s $f24, $f0
/* 0FC874 802D7EC4 8E050000 */  lw    $a1, ($s0)
/* 0FC878 802D7EC8 26100004 */  addiu $s0, $s0, 4
/* 0FC87C 802D7ECC 0220202D */  daddu $a0, $s1, $zero
/* 0FC880 802D7ED0 0C0B210B */  jal   func_802C842C
/* 0FC884 802D7ED4 46000586 */   mov.s $f22, $f0
/* 0FC888 802D7ED8 0220202D */  daddu $a0, $s1, $zero
/* 0FC88C 802D7EDC 8E050000 */  lw    $a1, ($s0)
/* 0FC890 802D7EE0 0C0B1EAF */  jal   func_802C7ABC
/* 0FC894 802D7EE4 46000506 */   mov.s $f20, $f0
/* 0FC898 802D7EE8 12400006 */  beqz  $s2, .L802D7F04
/* 0FC89C 802D7EEC 0040802D */   daddu $s0, $v0, $zero
/* 0FC8A0 802D7EF0 24020001 */  addiu $v0, $zero, 1
/* 0FC8A4 802D7EF4 12420014 */  beq   $s2, $v0, .L802D7F48
/* 0FC8A8 802D7EF8 4600D206 */   mov.s $f8, $f26
/* 0FC8AC 802D7EFC 080B5FF2 */  j     func_802D7FC8
/* 0FC8B0 802D7F00 4600C006 */   mov.s $f0, $f24

.L802D7F04:
/* 0FC8B4 802D7F04 3C055555 */  lui   $a1, 0x5555
/* 0FC8B8 802D7F08 3C048011 */  lui   $a0, 0x8011
/* 0FC8BC 802D7F0C 2484EFC8 */  addiu $a0, $a0, -0x1038
/* 0FC8C0 802D7F10 948200B0 */  lhu   $v0, 0xb0($a0)
/* 0FC8C4 802D7F14 34A55556 */  ori   $a1, $a1, 0x5556
/* 0FC8C8 802D7F18 00021400 */  sll   $v0, $v0, 0x10
/* 0FC8CC 802D7F1C 00021C03 */  sra   $v1, $v0, 0x10
/* 0FC8D0 802D7F20 00650018 */  mult  $v1, $a1
/* 0FC8D4 802D7F24 C4880028 */  lwc1  $f8, 0x28($a0)
/* 0FC8D8 802D7F28 C4860030 */  lwc1  $f6, 0x30($a0)
/* 0FC8DC 802D7F2C C482002C */  lwc1  $f2, 0x2c($a0)
/* 0FC8E0 802D7F30 00031840 */  sll   $v1, $v1, 1
/* 0FC8E4 802D7F34 00004010 */  mfhi  $t0
/* 0FC8E8 802D7F38 000217C3 */  sra   $v0, $v0, 0x1f
/* 0FC8EC 802D7F3C 01021023 */  subu  $v0, $t0, $v0
/* 0FC8F0 802D7F40 080B5FE5 */  j     func_802D7F94
/* 0FC8F4 802D7F44 00650018 */   mult  $v1, $a1

.L802D7F48:
/* 0FC8F8 802D7F48 0220202D */  daddu $a0, $s1, $zero
/* 0FC8FC 802D7F4C 0C0B36B0 */  jal   func_802CDAC0
/* 0FC900 802D7F50 0260282D */   daddu $a1, $s3, $zero
/* 0FC904 802D7F54 0040282D */  daddu $a1, $v0, $zero
/* 0FC908 802D7F58 10A00025 */  beqz  $a1, .L802D7FF0
/* 0FC90C 802D7F5C 3C045555 */   lui   $a0, 0x5555
/* 0FC910 802D7F60 94A200A8 */  lhu   $v0, 0xa8($a1)
/* 0FC914 802D7F64 34845556 */  ori   $a0, $a0, 0x5556
/* 0FC918 802D7F68 00021400 */  sll   $v0, $v0, 0x10
/* 0FC91C 802D7F6C 00021C03 */  sra   $v1, $v0, 0x10
/* 0FC920 802D7F70 00640018 */  mult  $v1, $a0
/* 0FC924 802D7F74 C4A80038 */  lwc1  $f8, 0x38($a1)
/* 0FC928 802D7F78 C4A60040 */  lwc1  $f6, 0x40($a1)
/* 0FC92C 802D7F7C C4A2003C */  lwc1  $f2, 0x3c($a1)
/* 0FC930 802D7F80 00031840 */  sll   $v1, $v1, 1
/* 0FC934 802D7F84 00004010 */  mfhi  $t0
/* 0FC938 802D7F88 000217C3 */  sra   $v0, $v0, 0x1f
/* 0FC93C 802D7F8C 01021023 */  subu  $v0, $t0, $v0
/* 0FC940 802D7F90 00640018 */  mult  $v1, $a0
func_802D7F94:
/* 0FC944 802D7F94 00021400 */  sll   $v0, $v0, 0x10
/* 0FC948 802D7F98 00021403 */  sra   $v0, $v0, 0x10
/* 0FC94C 802D7F9C 44822000 */  mtc1  $v0, $f4
/* 0FC950 802D7FA0 00000000 */  nop   
/* 0FC954 802D7FA4 46802120 */  cvt.s.w $f4, $f4
/* 0FC958 802D7FA8 00031FC3 */  sra   $v1, $v1, 0x1f
/* 0FC95C 802D7FAC 00004010 */  mfhi  $t0
/* 0FC960 802D7FB0 01031823 */  subu  $v1, $t0, $v1
/* 0FC964 802D7FB4 44830000 */  mtc1  $v1, $f0
/* 0FC968 802D7FB8 00000000 */  nop   
/* 0FC96C 802D7FBC 46800020 */  cvt.s.w $f0, $f0
/* 0FC970 802D7FC0 080B5FF4 */  j     func_802D7FD0
/* 0FC974 802D7FC4 46001000 */   add.s $f0, $f2, $f0

func_802D7FC8:
/* 0FC978 802D7FC8 4600B186 */  mov.s $f6, $f22
/* 0FC97C 802D7FCC 4600A106 */  mov.s $f4, $f20
func_802D7FD0:
/* 0FC980 802D7FD0 44054000 */  mfc1  $a1, $f8
/* 0FC984 802D7FD4 44060000 */  mfc1  $a2, $f0
/* 0FC988 802D7FD8 44073000 */  mfc1  $a3, $f6
/* 0FC98C 802D7FDC 0280202D */  daddu $a0, $s4, $zero
/* 0FC990 802D7FE0 E7A40010 */  swc1  $f4, 0x10($sp)
/* 0FC994 802D7FE4 E7BC0014 */  swc1  $f28, 0x14($sp)
/* 0FC998 802D7FE8 0C01C1E4 */  jal   func_80070790
/* 0FC99C 802D7FEC AFB00018 */   sw    $s0, 0x18($sp)
.L802D7FF0:
/* 0FC9A0 802D7FF0 24020002 */  addiu $v0, $zero, 2
/* 0FC9A4 802D7FF4 8FBF0034 */  lw    $ra, 0x34($sp)
/* 0FC9A8 802D7FF8 8FB40030 */  lw    $s4, 0x30($sp)
/* 0FC9AC 802D7FFC 8FB3002C */  lw    $s3, 0x2c($sp)
/* 0FC9B0 802D8000 8FB20028 */  lw    $s2, 0x28($sp)
/* 0FC9B4 802D8004 8FB10024 */  lw    $s1, 0x24($sp)
/* 0FC9B8 802D8008 8FB00020 */  lw    $s0, 0x20($sp)
/* 0FC9BC 802D800C D7BC0058 */  ldc1  $f28, 0x58($sp)
/* 0FC9C0 802D8010 D7BA0050 */  ldc1  $f26, 0x50($sp)
/* 0FC9C4 802D8014 D7B80048 */  ldc1  $f24, 0x48($sp)
/* 0FC9C8 802D8018 D7B60040 */  ldc1  $f22, 0x40($sp)
/* 0FC9CC 802D801C D7B40038 */  ldc1  $f20, 0x38($sp)
/* 0FC9D0 802D8020 03E00008 */  jr    $ra
/* 0FC9D4 802D8024 27BD0060 */   addiu $sp, $sp, 0x60

/* 0FC9D8 802D8028 27BDFFA0 */  addiu $sp, $sp, -0x60
/* 0FC9DC 802D802C AFB1002C */  sw    $s1, 0x2c($sp)
/* 0FC9E0 802D8030 0080882D */  daddu $s1, $a0, $zero
/* 0FC9E4 802D8034 AFBF003C */  sw    $ra, 0x3c($sp)
/* 0FC9E8 802D8038 AFB40038 */  sw    $s4, 0x38($sp)
/* 0FC9EC 802D803C AFB30034 */  sw    $s3, 0x34($sp)
/* 0FC9F0 802D8040 AFB20030 */  sw    $s2, 0x30($sp)
/* 0FC9F4 802D8044 AFB00028 */  sw    $s0, 0x28($sp)
/* 0FC9F8 802D8048 F7BA0058 */  sdc1  $f26, 0x58($sp)
/* 0FC9FC 802D804C F7B80050 */  sdc1  $f24, 0x50($sp)
/* 0FCA00 802D8050 F7B60048 */  sdc1  $f22, 0x48($sp)
/* 0FCA04 802D8054 F7B40040 */  sdc1  $f20, 0x40($sp)
/* 0FCA08 802D8058 8E30000C */  lw    $s0, 0xc($s1)
/* 0FCA0C 802D805C 8E050000 */  lw    $a1, ($s0)
/* 0FCA10 802D8060 0C0B1EAF */  jal   func_802C7ABC
/* 0FCA14 802D8064 26100004 */   addiu $s0, $s0, 4
/* 0FCA18 802D8068 8E050000 */  lw    $a1, ($s0)
/* 0FCA1C 802D806C 26100004 */  addiu $s0, $s0, 4
/* 0FCA20 802D8070 0220202D */  daddu $a0, $s1, $zero
/* 0FCA24 802D8074 0C0B1EAF */  jal   func_802C7ABC
/* 0FCA28 802D8078 0040982D */   daddu $s3, $v0, $zero
/* 0FCA2C 802D807C 8E050000 */  lw    $a1, ($s0)
/* 0FCA30 802D8080 26100004 */  addiu $s0, $s0, 4
/* 0FCA34 802D8084 0220202D */  daddu $a0, $s1, $zero
/* 0FCA38 802D8088 0C0B210B */  jal   func_802C842C
/* 0FCA3C 802D808C 0040A02D */   daddu $s4, $v0, $zero
/* 0FCA40 802D8090 8E050000 */  lw    $a1, ($s0)
/* 0FCA44 802D8094 26100004 */  addiu $s0, $s0, 4
/* 0FCA48 802D8098 0220202D */  daddu $a0, $s1, $zero
/* 0FCA4C 802D809C 0C0B1EAF */  jal   func_802C7ABC
/* 0FCA50 802D80A0 46000686 */   mov.s $f26, $f0
/* 0FCA54 802D80A4 8E050000 */  lw    $a1, ($s0)
/* 0FCA58 802D80A8 26100004 */  addiu $s0, $s0, 4
/* 0FCA5C 802D80AC 0220202D */  daddu $a0, $s1, $zero
/* 0FCA60 802D80B0 0C0B210B */  jal   func_802C842C
/* 0FCA64 802D80B4 0040902D */   daddu $s2, $v0, $zero
/* 0FCA68 802D80B8 8E050000 */  lw    $a1, ($s0)
/* 0FCA6C 802D80BC 26100004 */  addiu $s0, $s0, 4
/* 0FCA70 802D80C0 0220202D */  daddu $a0, $s1, $zero
/* 0FCA74 802D80C4 0C0B210B */  jal   func_802C842C
/* 0FCA78 802D80C8 46000606 */   mov.s $f24, $f0
/* 0FCA7C 802D80CC 8E050000 */  lw    $a1, ($s0)
/* 0FCA80 802D80D0 26100004 */  addiu $s0, $s0, 4
/* 0FCA84 802D80D4 0220202D */  daddu $a0, $s1, $zero
/* 0FCA88 802D80D8 0C0B210B */  jal   func_802C842C
/* 0FCA8C 802D80DC 46000586 */   mov.s $f22, $f0
/* 0FCA90 802D80E0 8E050000 */  lw    $a1, ($s0)
/* 0FCA94 802D80E4 26100004 */  addiu $s0, $s0, 4
/* 0FCA98 802D80E8 0220202D */  daddu $a0, $s1, $zero
/* 0FCA9C 802D80EC 0C0B210B */  jal   func_802C842C
/* 0FCAA0 802D80F0 46000506 */   mov.s $f20, $f0
/* 0FCAA4 802D80F4 8E100000 */  lw    $s0, ($s0)
/* 0FCAA8 802D80F8 12400006 */  beqz  $s2, .L802D8114
/* 0FCAAC 802D80FC 46000086 */   mov.s $f2, $f0
/* 0FCAB0 802D8100 24020001 */  addiu $v0, $zero, 1
/* 0FCAB4 802D8104 12420014 */  beq   $s2, $v0, .L802D8158
/* 0FCAB8 802D8108 4600C186 */   mov.s $f6, $f24
/* 0FCABC 802D810C 080B6076 */  j     func_802D81D8
/* 0FCAC0 802D8110 4600B006 */   mov.s $f0, $f22

.L802D8114:
/* 0FCAC4 802D8114 3C055555 */  lui   $a1, 0x5555
/* 0FCAC8 802D8118 3C048011 */  lui   $a0, 0x8011
/* 0FCACC 802D811C 2484EFC8 */  addiu $a0, $a0, -0x1038
/* 0FCAD0 802D8120 948200B0 */  lhu   $v0, 0xb0($a0)
/* 0FCAD4 802D8124 34A55556 */  ori   $a1, $a1, 0x5556
/* 0FCAD8 802D8128 00021400 */  sll   $v0, $v0, 0x10
/* 0FCADC 802D812C 00021C03 */  sra   $v1, $v0, 0x10
/* 0FCAE0 802D8130 00650018 */  mult  $v1, $a1
/* 0FCAE4 802D8134 C4860028 */  lwc1  $f6, 0x28($a0)
/* 0FCAE8 802D8138 C4880030 */  lwc1  $f8, 0x30($a0)
/* 0FCAEC 802D813C C482002C */  lwc1  $f2, 0x2c($a0)
/* 0FCAF0 802D8140 00031840 */  sll   $v1, $v1, 1
/* 0FCAF4 802D8144 00004010 */  mfhi  $t0
/* 0FCAF8 802D8148 000217C3 */  sra   $v0, $v0, 0x1f
/* 0FCAFC 802D814C 01021023 */  subu  $v0, $t0, $v0
/* 0FCB00 802D8150 080B6069 */  j     func_802D81A4
/* 0FCB04 802D8154 00650018 */   mult  $v1, $a1

.L802D8158:
/* 0FCB08 802D8158 0220202D */  daddu $a0, $s1, $zero
/* 0FCB0C 802D815C 0C0B36B0 */  jal   func_802CDAC0
/* 0FCB10 802D8160 0260282D */   daddu $a1, $s3, $zero
/* 0FCB14 802D8164 0040282D */  daddu $a1, $v0, $zero
/* 0FCB18 802D8168 10A0002A */  beqz  $a1, .L802D8214
/* 0FCB1C 802D816C 3C045555 */   lui   $a0, 0x5555
/* 0FCB20 802D8170 94A200A8 */  lhu   $v0, 0xa8($a1)
/* 0FCB24 802D8174 34845556 */  ori   $a0, $a0, 0x5556
/* 0FCB28 802D8178 00021400 */  sll   $v0, $v0, 0x10
/* 0FCB2C 802D817C 00021C03 */  sra   $v1, $v0, 0x10
/* 0FCB30 802D8180 00640018 */  mult  $v1, $a0
/* 0FCB34 802D8184 C4A60038 */  lwc1  $f6, 0x38($a1)
/* 0FCB38 802D8188 C4A80040 */  lwc1  $f8, 0x40($a1)
/* 0FCB3C 802D818C C4A2003C */  lwc1  $f2, 0x3c($a1)
/* 0FCB40 802D8190 00031840 */  sll   $v1, $v1, 1
/* 0FCB44 802D8194 00004010 */  mfhi  $t0
/* 0FCB48 802D8198 000217C3 */  sra   $v0, $v0, 0x1f
/* 0FCB4C 802D819C 01021023 */  subu  $v0, $t0, $v0
/* 0FCB50 802D81A0 00640018 */  mult  $v1, $a0
func_802D81A4:
/* 0FCB54 802D81A4 00021400 */  sll   $v0, $v0, 0x10
/* 0FCB58 802D81A8 00021403 */  sra   $v0, $v0, 0x10
/* 0FCB5C 802D81AC 44822000 */  mtc1  $v0, $f4
/* 0FCB60 802D81B0 00000000 */  nop   
/* 0FCB64 802D81B4 46802120 */  cvt.s.w $f4, $f4
/* 0FCB68 802D81B8 00031FC3 */  sra   $v1, $v1, 0x1f
/* 0FCB6C 802D81BC 00004010 */  mfhi  $t0
/* 0FCB70 802D81C0 01031823 */  subu  $v1, $t0, $v1
/* 0FCB74 802D81C4 44830000 */  mtc1  $v1, $f0
/* 0FCB78 802D81C8 00000000 */  nop   
/* 0FCB7C 802D81CC 46800020 */  cvt.s.w $f0, $f0
/* 0FCB80 802D81D0 080B6078 */  j     func_802D81E0
/* 0FCB84 802D81D4 46001000 */   add.s $f0, $f2, $f0

func_802D81D8:
/* 0FCB88 802D81D8 4600A206 */  mov.s $f8, $f20
/* 0FCB8C 802D81DC 46001106 */  mov.s $f4, $f2
func_802D81E0:
/* 0FCB90 802D81E0 0280202D */  daddu $a0, $s4, $zero
/* 0FCB94 802D81E4 44053000 */  mfc1  $a1, $f6
/* 0FCB98 802D81E8 44060000 */  mfc1  $a2, $f0
/* 0FCB9C 802D81EC 44074000 */  mfc1  $a3, $f8
/* 0FCBA0 802D81F0 27A20020 */  addiu $v0, $sp, 0x20
/* 0FCBA4 802D81F4 E7A40010 */  swc1  $f4, 0x10($sp)
/* 0FCBA8 802D81F8 E7BA0014 */  swc1  $f26, 0x14($sp)
/* 0FCBAC 802D81FC 0C01C1FC */  jal   func_800707F0
/* 0FCBB0 802D8200 AFA20018 */   sw    $v0, 0x18($sp)
/* 0FCBB4 802D8204 0220202D */  daddu $a0, $s1, $zero
/* 0FCBB8 802D8208 8FA60020 */  lw    $a2, 0x20($sp)
/* 0FCBBC 802D820C 0C0B2026 */  jal   func_802C8098
/* 0FCBC0 802D8210 0200282D */   daddu $a1, $s0, $zero
.L802D8214:
/* 0FCBC4 802D8214 24020002 */  addiu $v0, $zero, 2
/* 0FCBC8 802D8218 8FBF003C */  lw    $ra, 0x3c($sp)
/* 0FCBCC 802D821C 8FB40038 */  lw    $s4, 0x38($sp)
/* 0FCBD0 802D8220 8FB30034 */  lw    $s3, 0x34($sp)
/* 0FCBD4 802D8224 8FB20030 */  lw    $s2, 0x30($sp)
/* 0FCBD8 802D8228 8FB1002C */  lw    $s1, 0x2c($sp)
/* 0FCBDC 802D822C 8FB00028 */  lw    $s0, 0x28($sp)
/* 0FCBE0 802D8230 D7BA0058 */  ldc1  $f26, 0x58($sp)
/* 0FCBE4 802D8234 D7B80050 */  ldc1  $f24, 0x50($sp)
/* 0FCBE8 802D8238 D7B60048 */  ldc1  $f22, 0x48($sp)
/* 0FCBEC 802D823C D7B40040 */  ldc1  $f20, 0x40($sp)
/* 0FCBF0 802D8240 03E00008 */  jr    $ra
/* 0FCBF4 802D8244 27BD0060 */   addiu $sp, $sp, 0x60

/* 0FCBF8 802D8248 27BDFFE0 */  addiu $sp, $sp, -0x20
/* 0FCBFC 802D824C AFB10014 */  sw    $s1, 0x14($sp)
/* 0FCC00 802D8250 0080882D */  daddu $s1, $a0, $zero
/* 0FCC04 802D8254 AFBF0018 */  sw    $ra, 0x18($sp)
/* 0FCC08 802D8258 AFB00010 */  sw    $s0, 0x10($sp)
/* 0FCC0C 802D825C 8E30000C */  lw    $s0, 0xc($s1)
/* 0FCC10 802D8260 8E050000 */  lw    $a1, ($s0)
/* 0FCC14 802D8264 0C0B1EAF */  jal   func_802C7ABC
/* 0FCC18 802D8268 26100004 */   addiu $s0, $s0, 4
/* 0FCC1C 802D826C 0220202D */  daddu $a0, $s1, $zero
/* 0FCC20 802D8270 8E050000 */  lw    $a1, ($s0)
/* 0FCC24 802D8274 0C0B1EAF */  jal   func_802C7ABC
/* 0FCC28 802D8278 0040802D */   daddu $s0, $v0, $zero
/* 0FCC2C 802D827C 8E03000C */  lw    $v1, 0xc($s0)
/* 0FCC30 802D8280 AC62001C */  sw    $v0, 0x1c($v1)
/* 0FCC34 802D8284 8FBF0018 */  lw    $ra, 0x18($sp)
/* 0FCC38 802D8288 8FB10014 */  lw    $s1, 0x14($sp)
/* 0FCC3C 802D828C 8FB00010 */  lw    $s0, 0x10($sp)
/* 0FCC40 802D8290 24020002 */  addiu $v0, $zero, 2
/* 0FCC44 802D8294 03E00008 */  jr    $ra
/* 0FCC48 802D8298 27BD0020 */   addiu $sp, $sp, 0x20

/* 0FCC4C 802D829C 27BDFF38 */  addiu $sp, $sp, -0xc8
/* 0FCC50 802D82A0 AFBF0094 */  sw    $ra, 0x94($sp)
/* 0FCC54 802D82A4 AFBE0090 */  sw    $fp, 0x90($sp)
/* 0FCC58 802D82A8 AFB7008C */  sw    $s7, 0x8c($sp)
/* 0FCC5C 802D82AC AFB60088 */  sw    $s6, 0x88($sp)
/* 0FCC60 802D82B0 AFB50084 */  sw    $s5, 0x84($sp)
/* 0FCC64 802D82B4 AFB40080 */  sw    $s4, 0x80($sp)
/* 0FCC68 802D82B8 AFB3007C */  sw    $s3, 0x7c($sp)
/* 0FCC6C 802D82BC AFB20078 */  sw    $s2, 0x78($sp)
/* 0FCC70 802D82C0 AFB10074 */  sw    $s1, 0x74($sp)
/* 0FCC74 802D82C4 AFB00070 */  sw    $s0, 0x70($sp)
/* 0FCC78 802D82C8 F7BE00C0 */  sdc1  $f30, 0xc0($sp)
/* 0FCC7C 802D82CC F7BC00B8 */  sdc1  $f28, 0xb8($sp)
/* 0FCC80 802D82D0 F7BA00B0 */  sdc1  $f26, 0xb0($sp)
/* 0FCC84 802D82D4 F7B800A8 */  sdc1  $f24, 0xa8($sp)
/* 0FCC88 802D82D8 F7B600A0 */  sdc1  $f22, 0xa0($sp)
/* 0FCC8C 802D82DC F7B40098 */  sdc1  $f20, 0x98($sp)
/* 0FCC90 802D82E0 AFA400C8 */  sw    $a0, 0xc8($sp)
/* 0FCC94 802D82E4 8C90000C */  lw    $s0, 0xc($a0)
/* 0FCC98 802D82E8 0000A82D */  daddu $s5, $zero, $zero
/* 0FCC9C 802D82EC 0200882D */  daddu $s1, $s0, $zero
/* 0FCCA0 802D82F0 8E050000 */  lw    $a1, ($s0)
/* 0FCCA4 802D82F4 0C0B1EAF */  jal   func_802C7ABC
/* 0FCCA8 802D82F8 0200902D */   daddu $s2, $s0, $zero
/* 0FCCAC 802D82FC 8E250000 */  lw    $a1, ($s1)
/* 0FCCB0 802D8300 8FA400C8 */  lw    $a0, 0xc8($sp)
/* 0FCCB4 802D8304 26100004 */  addiu $s0, $s0, 4
/* 0FCCB8 802D8308 0C0B1EAF */  jal   func_802C7ABC
/* 0FCCBC 802D830C AFA20040 */   sw    $v0, 0x40($sp)
/* 0FCCC0 802D8310 8E450000 */  lw    $a1, ($s2)
/* 0FCCC4 802D8314 8FA400C8 */  lw    $a0, 0xc8($sp)
/* 0FCCC8 802D8318 0C0B1EAF */  jal   func_802C7ABC
/* 0FCCCC 802D831C 26310004 */   addiu $s1, $s1, 4
/* 0FCCD0 802D8320 8E050000 */  lw    $a1, ($s0)
/* 0FCCD4 802D8324 8FA400C8 */  lw    $a0, 0xc8($sp)
/* 0FCCD8 802D8328 0C0B1EAF */  jal   func_802C7ABC
/* 0FCCDC 802D832C 26100004 */   addiu $s0, $s0, 4
/* 0FCCE0 802D8330 8E050000 */  lw    $a1, ($s0)
/* 0FCCE4 802D8334 26100004 */  addiu $s0, $s0, 4
/* 0FCCE8 802D8338 8FA400C8 */  lw    $a0, 0xc8($sp)
/* 0FCCEC 802D833C 0C0B1EAF */  jal   func_802C7ABC
/* 0FCCF0 802D8340 0040982D */   daddu $s3, $v0, $zero
/* 0FCCF4 802D8344 8E050000 */  lw    $a1, ($s0)
/* 0FCCF8 802D8348 8FA400C8 */  lw    $a0, 0xc8($sp)
/* 0FCCFC 802D834C 26100004 */  addiu $s0, $s0, 4
/* 0FCD00 802D8350 0C0B1EAF */  jal   func_802C7ABC
/* 0FCD04 802D8354 AFA20044 */   sw    $v0, 0x44($sp)
/* 0FCD08 802D8358 8E050000 */  lw    $a1, ($s0)
/* 0FCD0C 802D835C 8FA400C8 */  lw    $a0, 0xc8($sp)
/* 0FCD10 802D8360 26100004 */  addiu $s0, $s0, 4
/* 0FCD14 802D8364 0C0B1EAF */  jal   func_802C7ABC
/* 0FCD18 802D8368 AFA20048 */   sw    $v0, 0x48($sp)
/* 0FCD1C 802D836C 8E050000 */  lw    $a1, ($s0)
/* 0FCD20 802D8370 8FA400C8 */  lw    $a0, 0xc8($sp)
/* 0FCD24 802D8374 26100004 */  addiu $s0, $s0, 4
/* 0FCD28 802D8378 0C0B1EAF */  jal   func_802C7ABC
/* 0FCD2C 802D837C AFA2004C */   sw    $v0, 0x4c($sp)
/* 0FCD30 802D8380 8E050000 */  lw    $a1, ($s0)
/* 0FCD34 802D8384 26100004 */  addiu $s0, $s0, 4
/* 0FCD38 802D8388 8FA400C8 */  lw    $a0, 0xc8($sp)
/* 0FCD3C 802D838C 0C0B1EAF */  jal   func_802C7ABC
/* 0FCD40 802D8390 0040B02D */   daddu $s6, $v0, $zero
/* 0FCD44 802D8394 8E050000 */  lw    $a1, ($s0)
/* 0FCD48 802D8398 26100004 */  addiu $s0, $s0, 4
/* 0FCD4C 802D839C 8FA400C8 */  lw    $a0, 0xc8($sp)
/* 0FCD50 802D83A0 0C0B1EAF */  jal   func_802C7ABC
/* 0FCD54 802D83A4 0040A02D */   daddu $s4, $v0, $zero
/* 0FCD58 802D83A8 8E050000 */  lw    $a1, ($s0)
/* 0FCD5C 802D83AC 8FA400C8 */  lw    $a0, 0xc8($sp)
/* 0FCD60 802D83B0 26100004 */  addiu $s0, $s0, 4
/* 0FCD64 802D83B4 0C0B1EAF */  jal   func_802C7ABC
/* 0FCD68 802D83B8 AFA20050 */   sw    $v0, 0x50($sp)
/* 0FCD6C 802D83BC 8E050000 */  lw    $a1, ($s0)
/* 0FCD70 802D83C0 26100004 */  addiu $s0, $s0, 4
/* 0FCD74 802D83C4 8FA400C8 */  lw    $a0, 0xc8($sp)
/* 0FCD78 802D83C8 0C0B1EAF */  jal   func_802C7ABC
/* 0FCD7C 802D83CC 0040B82D */   daddu $s7, $v0, $zero
/* 0FCD80 802D83D0 8E050000 */  lw    $a1, ($s0)
/* 0FCD84 802D83D4 26100004 */  addiu $s0, $s0, 4
/* 0FCD88 802D83D8 8FA400C8 */  lw    $a0, 0xc8($sp)
/* 0FCD8C 802D83DC 0C0B1EAF */  jal   func_802C7ABC
/* 0FCD90 802D83E0 0040F02D */   daddu $fp, $v0, $zero
/* 0FCD94 802D83E4 8E050000 */  lw    $a1, ($s0)
/* 0FCD98 802D83E8 8FA400C8 */  lw    $a0, 0xc8($sp)
/* 0FCD9C 802D83EC 26100004 */  addiu $s0, $s0, 4
/* 0FCDA0 802D83F0 0C0B1EAF */  jal   func_802C7ABC
/* 0FCDA4 802D83F4 AFA20054 */   sw    $v0, 0x54($sp)
/* 0FCDA8 802D83F8 8E050000 */  lw    $a1, ($s0)
/* 0FCDAC 802D83FC 8FA400C8 */  lw    $a0, 0xc8($sp)
/* 0FCDB0 802D8400 0C0B1EAF */  jal   func_802C7ABC
/* 0FCDB4 802D8404 26100004 */   addiu $s0, $s0, 4
/* 0FCDB8 802D8408 8E050000 */  lw    $a1, ($s0)
/* 0FCDBC 802D840C 8FA400C8 */  lw    $a0, 0xc8($sp)
/* 0FCDC0 802D8410 0C0B1EAF */  jal   func_802C7ABC
/* 0FCDC4 802D8414 26520004 */   addiu $s2, $s2, 4
/* 0FCDC8 802D8418 8E250000 */  lw    $a1, ($s1)
/* 0FCDCC 802D841C 8FA400C8 */  lw    $a0, 0xc8($sp)
/* 0FCDD0 802D8420 0C0B210B */  jal   func_802C842C
/* 0FCDD4 802D8424 26310004 */   addiu $s1, $s1, 4
/* 0FCDD8 802D8428 8E250000 */  lw    $a1, ($s1)
/* 0FCDDC 802D842C 8FA400C8 */  lw    $a0, 0xc8($sp)
/* 0FCDE0 802D8430 26310004 */  addiu $s1, $s1, 4
/* 0FCDE4 802D8434 0C0B210B */  jal   func_802C842C
/* 0FCDE8 802D8438 E7A00058 */   swc1  $f0, 0x58($sp)
/* 0FCDEC 802D843C 8E250000 */  lw    $a1, ($s1)
/* 0FCDF0 802D8440 26310004 */  addiu $s1, $s1, 4
/* 0FCDF4 802D8444 8FA400C8 */  lw    $a0, 0xc8($sp)
/* 0FCDF8 802D8448 0C0B210B */  jal   func_802C842C
/* 0FCDFC 802D844C 46000506 */   mov.s $f20, $f0
/* 0FCE00 802D8450 8E250000 */  lw    $a1, ($s1)
/* 0FCE04 802D8454 26310004 */  addiu $s1, $s1, 4
/* 0FCE08 802D8458 8FA400C8 */  lw    $a0, 0xc8($sp)
/* 0FCE0C 802D845C 0C0B210B */  jal   func_802C842C
/* 0FCE10 802D8460 46000586 */   mov.s $f22, $f0
/* 0FCE14 802D8464 8E250000 */  lw    $a1, ($s1)
/* 0FCE18 802D8468 26310004 */  addiu $s1, $s1, 4
/* 0FCE1C 802D846C 8FA400C8 */  lw    $a0, 0xc8($sp)
/* 0FCE20 802D8470 0C0B210B */  jal   func_802C842C
/* 0FCE24 802D8474 46000606 */   mov.s $f24, $f0
/* 0FCE28 802D8478 8E250000 */  lw    $a1, ($s1)
/* 0FCE2C 802D847C 26310004 */  addiu $s1, $s1, 4
/* 0FCE30 802D8480 8FA400C8 */  lw    $a0, 0xc8($sp)
/* 0FCE34 802D8484 0C0B210B */  jal   func_802C842C
/* 0FCE38 802D8488 46000686 */   mov.s $f26, $f0
/* 0FCE3C 802D848C 8E250000 */  lw    $a1, ($s1)
/* 0FCE40 802D8490 26310004 */  addiu $s1, $s1, 4
/* 0FCE44 802D8494 8FA400C8 */  lw    $a0, 0xc8($sp)
/* 0FCE48 802D8498 0C0B210B */  jal   func_802C842C
/* 0FCE4C 802D849C 46000706 */   mov.s $f28, $f0
/* 0FCE50 802D84A0 8E250000 */  lw    $a1, ($s1)
/* 0FCE54 802D84A4 26310004 */  addiu $s1, $s1, 4
/* 0FCE58 802D84A8 8FA400C8 */  lw    $a0, 0xc8($sp)
/* 0FCE5C 802D84AC 0C0B210B */  jal   func_802C842C
/* 0FCE60 802D84B0 46000786 */   mov.s $f30, $f0
/* 0FCE64 802D84B4 8E250000 */  lw    $a1, ($s1)
/* 0FCE68 802D84B8 8FA400C8 */  lw    $a0, 0xc8($sp)
/* 0FCE6C 802D84BC 26310004 */  addiu $s1, $s1, 4
/* 0FCE70 802D84C0 0C0B210B */  jal   func_802C842C
/* 0FCE74 802D84C4 E7A0005C */   swc1  $f0, 0x5c($sp)
/* 0FCE78 802D84C8 8E250000 */  lw    $a1, ($s1)
/* 0FCE7C 802D84CC 8FA400C8 */  lw    $a0, 0xc8($sp)
/* 0FCE80 802D84D0 26310004 */  addiu $s1, $s1, 4
/* 0FCE84 802D84D4 0C0B210B */  jal   func_802C842C
/* 0FCE88 802D84D8 E7A00060 */   swc1  $f0, 0x60($sp)
/* 0FCE8C 802D84DC 8E250000 */  lw    $a1, ($s1)
/* 0FCE90 802D84E0 8FA400C8 */  lw    $a0, 0xc8($sp)
/* 0FCE94 802D84E4 26310004 */  addiu $s1, $s1, 4
/* 0FCE98 802D84E8 0C0B210B */  jal   func_802C842C
/* 0FCE9C 802D84EC E7A00064 */   swc1  $f0, 0x64($sp)
/* 0FCEA0 802D84F0 8E250000 */  lw    $a1, ($s1)
/* 0FCEA4 802D84F4 8FA400C8 */  lw    $a0, 0xc8($sp)
/* 0FCEA8 802D84F8 26310004 */  addiu $s1, $s1, 4
/* 0FCEAC 802D84FC 0C0B210B */  jal   func_802C842C
/* 0FCEB0 802D8500 E7A00068 */   swc1  $f0, 0x68($sp)
/* 0FCEB4 802D8504 8E250000 */  lw    $a1, ($s1)
/* 0FCEB8 802D8508 8FA400C8 */  lw    $a0, 0xc8($sp)
/* 0FCEBC 802D850C 0C0B210B */  jal   func_802C842C
/* 0FCEC0 802D8510 26520004 */   addiu $s2, $s2, 4
/* 0FCEC4 802D8514 8E450000 */  lw    $a1, ($s2)
/* 0FCEC8 802D8518 26520010 */  addiu $s2, $s2, 0x10
/* 0FCECC 802D851C 8E500000 */  lw    $s0, ($s2)
/* 0FCED0 802D8520 26520004 */  addiu $s2, $s2, 4
/* 0FCED4 802D8524 8E430000 */  lw    $v1, ($s2)
/* 0FCED8 802D8528 26520004 */  addiu $s2, $s2, 4
/* 0FCEDC 802D852C 0260202D */  daddu $a0, $s3, $zero
/* 0FCEE0 802D8530 AFA3006C */  sw    $v1, 0x6c($sp)
/* 0FCEE4 802D8534 8FA30040 */  lw    $v1, 0x40($sp)
/* 0FCEE8 802D8538 8E530000 */  lw    $s3, ($s2)
/* 0FCEEC 802D853C 8E510004 */  lw    $s1, 4($s2)
/* 0FCEF0 802D8540 2C620087 */  sltiu $v0, $v1, 0x87
/* 0FCEF4 802D8544 10400450 */  beqz  $v0, .L802D9688
/* 0FCEF8 802D8548 00031080 */   sll   $v0, $v1, 2
/* 0FCEFC 802D854C 3C01802E */  lui   $at, 0x802e
/* 0FCF00 802D8550 00220821 */  addu  $at, $at, $v0
/* 0FCF04 802D8554 8C22A258 */  lw    $v0, -0x5da8($at)
/* 0FCF08 802D8558 00400008 */  jr    $v0
/* 0FCF0C 802D855C 00000000 */   nop   
/* 0FCF10 802D8560 8FA50058 */  lw    $a1, 0x58($sp)
/* 0FCF14 802D8564 4406A000 */  mfc1  $a2, $f20
/* 0FCF18 802D8568 4407B000 */  mfc1  $a3, $f22
/* 0FCF1C 802D856C 3C014040 */  lui   $at, 0x4040
/* 0FCF20 802D8570 44810000 */  mtc1  $at, $f0
/* 0FCF24 802D8574 0000202D */  daddu $a0, $zero, $zero
/* 0FCF28 802D8578 AFB60014 */  sw    $s6, 0x14($sp)
/* 0FCF2C 802D857C 0C01C3F4 */  jal   func_80070FD0
/* 0FCF30 802D8580 E7A00010 */   swc1  $f0, 0x10($sp)
/* 0FCF34 802D8584 080B65A4 */  j     func_802D9690
/* 0FCF38 802D8588 00000000 */   nop   

/* 0FCF3C 802D858C C7AC0058 */  lwc1  $f12, 0x58($sp)
/* 0FCF40 802D8590 4406B000 */  mfc1  $a2, $f22
/* 0FCF44 802D8594 0C01BE3C */  jal   func_8006F8F0
/* 0FCF48 802D8598 4600A386 */   mov.s $f14, $f20
/* 0FCF4C 802D859C 080B65A4 */  j     func_802D9690
/* 0FCF50 802D85A0 00000000 */   nop   

/* 0FCF54 802D85A4 4405A000 */  mfc1  $a1, $f20
/* 0FCF58 802D85A8 4406B000 */  mfc1  $a2, $f22
/* 0FCF5C 802D85AC 4407C000 */  mfc1  $a3, $f24
/* 0FCF60 802D85B0 0C01BEB4 */  jal   func_8006FAD0
/* 0FCF64 802D85B4 E7BA0010 */   swc1  $f26, 0x10($sp)
/* 0FCF68 802D85B8 080B65A4 */  j     func_802D9690
/* 0FCF6C 802D85BC 00000000 */   nop   

/* 0FCF70 802D85C0 4405A000 */  mfc1  $a1, $f20
/* 0FCF74 802D85C4 4406B000 */  mfc1  $a2, $f22
/* 0FCF78 802D85C8 4407C000 */  mfc1  $a3, $f24
/* 0FCF7C 802D85CC E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FCF80 802D85D0 0C01BECC */  jal   func_8006FB30
/* 0FCF84 802D85D4 E7BC0014 */   swc1  $f28, 0x14($sp)
/* 0FCF88 802D85D8 080B65A4 */  j     func_802D9690
/* 0FCF8C 802D85DC 00000000 */   nop   

/* 0FCF90 802D85E0 C7AC0058 */  lwc1  $f12, 0x58($sp)
/* 0FCF94 802D85E4 4406B000 */  mfc1  $a2, $f22
/* 0FCF98 802D85E8 4407C000 */  mfc1  $a3, $f24
/* 0FCF9C 802D85EC 0C01BEE4 */  jal   func_8006FB90
/* 0FCFA0 802D85F0 4600A386 */   mov.s $f14, $f20
/* 0FCFA4 802D85F4 080B65A4 */  j     func_802D9690
/* 0FCFA8 802D85F8 00000000 */   nop   

/* 0FCFAC 802D85FC 4405A000 */  mfc1  $a1, $f20
/* 0FCFB0 802D8600 4406B000 */  mfc1  $a2, $f22
/* 0FCFB4 802D8604 4407C000 */  mfc1  $a3, $f24
/* 0FCFB8 802D8608 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FCFBC 802D860C 0C01BEFC */  jal   func_8006FBF0
/* 0FCFC0 802D8610 E7BC0014 */   swc1  $f28, 0x14($sp)
/* 0FCFC4 802D8614 080B65A4 */  j     func_802D9690
/* 0FCFC8 802D8618 00000000 */   nop   

/* 0FCFCC 802D861C C7AC0058 */  lwc1  $f12, 0x58($sp)
/* 0FCFD0 802D8620 4406B000 */  mfc1  $a2, $f22
/* 0FCFD4 802D8624 4407C000 */  mfc1  $a3, $f24
/* 0FCFD8 802D8628 0C01BF14 */  jal   func_8006FC50
/* 0FCFDC 802D862C 4600A386 */   mov.s $f14, $f20
/* 0FCFE0 802D8630 080B65A4 */  j     func_802D9690
/* 0FCFE4 802D8634 00000000 */   nop   

/* 0FCFE8 802D8638 4405A000 */  mfc1  $a1, $f20
/* 0FCFEC 802D863C 4406B000 */  mfc1  $a2, $f22
/* 0FCFF0 802D8640 4407C000 */  mfc1  $a3, $f24
/* 0FCFF4 802D8644 0C01BF2C */  jal   func_8006FCB0
/* 0FCFF8 802D8648 00000000 */   nop   
/* 0FCFFC 802D864C 080B65A4 */  j     func_802D9690
/* 0FD000 802D8650 00000000 */   nop   

/* 0FD004 802D8654 C7AC0058 */  lwc1  $f12, 0x58($sp)
/* 0FD008 802D8658 4406B000 */  mfc1  $a2, $f22
/* 0FD00C 802D865C 4407C000 */  mfc1  $a3, $f24
/* 0FD010 802D8660 4600A386 */  mov.s $f14, $f20
/* 0FD014 802D8664 0C01BF44 */  jal   func_8006FD10
/* 0FD018 802D8668 E7BA0010 */   swc1  $f26, 0x10($sp)
/* 0FD01C 802D866C 080B65A4 */  j     func_802D9690
/* 0FD020 802D8670 00000000 */   nop   

/* 0FD024 802D8674 8FA50058 */  lw    $a1, 0x58($sp)
/* 0FD028 802D8678 4406A000 */  mfc1  $a2, $f20
/* 0FD02C 802D867C 4407B000 */  mfc1  $a3, $f22
/* 0FD030 802D8680 8FA3004C */  lw    $v1, 0x4c($sp)
/* 0FD034 802D8684 0000202D */  daddu $a0, $zero, $zero
/* 0FD038 802D8688 0C01BF5C */  jal   func_8006FD70
/* 0FD03C 802D868C AFA30010 */   sw    $v1, 0x10($sp)
/* 0FD040 802D8690 080B65A4 */  j     func_802D9690
/* 0FD044 802D8694 00000000 */   nop   

/* 0FD048 802D8698 C7AC0058 */  lwc1  $f12, 0x58($sp)
/* 0FD04C 802D869C 4406B000 */  mfc1  $a2, $f22
/* 0FD050 802D86A0 8FA7004C */  lw    $a3, 0x4c($sp)
/* 0FD054 802D86A4 0C01BF74 */  jal   func_8006FDD0
/* 0FD058 802D86A8 4600A386 */   mov.s $f14, $f20
/* 0FD05C 802D86AC 080B65A4 */  j     func_802D9690
/* 0FD060 802D86B0 00000000 */   nop   

/* 0FD064 802D86B4 4405A000 */  mfc1  $a1, $f20
/* 0FD068 802D86B8 4406B000 */  mfc1  $a2, $f22
/* 0FD06C 802D86BC 4407C000 */  mfc1  $a3, $f24
/* 0FD070 802D86C0 C7A2005C */  lwc1  $f2, 0x5c($sp)
/* 0FD074 802D86C4 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD078 802D86C8 E7BC0014 */  swc1  $f28, 0x14($sp)
/* 0FD07C 802D86CC E7BE0018 */  swc1  $f30, 0x18($sp)
/* 0FD080 802D86D0 0C01BF8C */  jal   func_8006FE30
/* 0FD084 802D86D4 E7A2001C */   swc1  $f2, 0x1c($sp)
/* 0FD088 802D86D8 080B65A4 */  j     func_802D9690
/* 0FD08C 802D86DC 00000000 */   nop   

/* 0FD090 802D86E0 4406B000 */  mfc1  $a2, $f22
/* 0FD094 802D86E4 4407C000 */  mfc1  $a3, $f24
/* 0FD098 802D86E8 27A20030 */  addiu $v0, $sp, 0x30
/* 0FD09C 802D86EC E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD0A0 802D86F0 E7BC0014 */  swc1  $f28, 0x14($sp)
/* 0FD0A4 802D86F4 E7BE0018 */  swc1  $f30, 0x18($sp)
/* 0FD0A8 802D86F8 AFB7001C */  sw    $s7, 0x1c($sp)
/* 0FD0AC 802D86FC 0C01BFA4 */  jal   func_8006FE90
/* 0FD0B0 802D8700 AFA20020 */   sw    $v0, 0x20($sp)
/* 0FD0B4 802D8704 080B6234 */  j     func_802D88D0
/* 0FD0B8 802D8708 00000000 */   nop   

/* 0FD0BC 802D870C 4405A000 */  mfc1  $a1, $f20
/* 0FD0C0 802D8710 4406B000 */  mfc1  $a2, $f22
/* 0FD0C4 802D8714 4407C000 */  mfc1  $a3, $f24
/* 0FD0C8 802D8718 0C01BFBC */  jal   func_8006FEF0
/* 0FD0CC 802D871C E7BA0010 */   swc1  $f26, 0x10($sp)
/* 0FD0D0 802D8720 080B65A4 */  j     func_802D9690
/* 0FD0D4 802D8724 00000000 */   nop   

/* 0FD0D8 802D8728 4405A000 */  mfc1  $a1, $f20
/* 0FD0DC 802D872C 4406B000 */  mfc1  $a2, $f22
/* 0FD0E0 802D8730 4407C000 */  mfc1  $a3, $f24
/* 0FD0E4 802D8734 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD0E8 802D8738 E7BC0014 */  swc1  $f28, 0x14($sp)
/* 0FD0EC 802D873C E7BE0018 */  swc1  $f30, 0x18($sp)
/* 0FD0F0 802D8740 0C01BFD4 */  jal   func_8006FF50
/* 0FD0F4 802D8744 AFB7001C */   sw    $s7, 0x1c($sp)
/* 0FD0F8 802D8748 080B65A4 */  j     func_802D9690
/* 0FD0FC 802D874C 00000000 */   nop   

/* 0FD100 802D8750 4405A000 */  mfc1  $a1, $f20
/* 0FD104 802D8754 4406B000 */  mfc1  $a2, $f22
/* 0FD108 802D8758 4407C000 */  mfc1  $a3, $f24
/* 0FD10C 802D875C E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD110 802D8760 0C01BFEC */  jal   func_8006FFB0
/* 0FD114 802D8764 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FD118 802D8768 080B65A4 */  j     func_802D9690
/* 0FD11C 802D876C 00000000 */   nop   

/* 0FD120 802D8770 4405A000 */  mfc1  $a1, $f20
/* 0FD124 802D8774 4406B000 */  mfc1  $a2, $f22
/* 0FD128 802D8778 4407C000 */  mfc1  $a3, $f24
/* 0FD12C 802D877C 0C01C004 */  jal   func_80070010
/* 0FD130 802D8780 AFB60010 */   sw    $s6, 0x10($sp)
/* 0FD134 802D8784 080B65A4 */  j     func_802D9690
/* 0FD138 802D8788 00000000 */   nop   

/* 0FD13C 802D878C 4405A000 */  mfc1  $a1, $f20
/* 0FD140 802D8790 4406B000 */  mfc1  $a2, $f22
/* 0FD144 802D8794 4407C000 */  mfc1  $a3, $f24
/* 0FD148 802D8798 0C01C01C */  jal   func_80070070
/* 0FD14C 802D879C AFB60010 */   sw    $s6, 0x10($sp)
/* 0FD150 802D87A0 080B65A4 */  j     func_802D9690
/* 0FD154 802D87A4 00000000 */   nop   

/* 0FD158 802D87A8 4405A000 */  mfc1  $a1, $f20
/* 0FD15C 802D87AC 4406B000 */  mfc1  $a2, $f22
/* 0FD160 802D87B0 4407C000 */  mfc1  $a3, $f24
/* 0FD164 802D87B4 0C01C034 */  jal   func_800700D0
/* 0FD168 802D87B8 E7BA0010 */   swc1  $f26, 0x10($sp)
/* 0FD16C 802D87BC 080B65A4 */  j     func_802D9690
/* 0FD170 802D87C0 00000000 */   nop   

/* 0FD174 802D87C4 4405A000 */  mfc1  $a1, $f20
/* 0FD178 802D87C8 4406B000 */  mfc1  $a2, $f22
/* 0FD17C 802D87CC 4407C000 */  mfc1  $a3, $f24
/* 0FD180 802D87D0 0C01C04C */  jal   func_80070130
/* 0FD184 802D87D4 00000000 */   nop   
/* 0FD188 802D87D8 080B65A4 */  j     func_802D9690
/* 0FD18C 802D87DC 00000000 */   nop   

/* 0FD190 802D87E0 4405A000 */  mfc1  $a1, $f20
/* 0FD194 802D87E4 4406B000 */  mfc1  $a2, $f22
/* 0FD198 802D87E8 4407C000 */  mfc1  $a3, $f24
/* 0FD19C 802D87EC E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD1A0 802D87F0 E7BC0014 */  swc1  $f28, 0x14($sp)
/* 0FD1A4 802D87F4 E7BE0018 */  swc1  $f30, 0x18($sp)
/* 0FD1A8 802D87F8 0C01C064 */  jal   func_80070190
/* 0FD1AC 802D87FC AFB7001C */   sw    $s7, 0x1c($sp)
/* 0FD1B0 802D8800 080B65A4 */  j     func_802D9690
/* 0FD1B4 802D8804 00000000 */   nop   

/* 0FD1B8 802D8808 4405A000 */  mfc1  $a1, $f20
/* 0FD1BC 802D880C 4406B000 */  mfc1  $a2, $f22
/* 0FD1C0 802D8810 4407C000 */  mfc1  $a3, $f24
/* 0FD1C4 802D8814 0C01C07C */  jal   func_800701F0
/* 0FD1C8 802D8818 00000000 */   nop   
/* 0FD1CC 802D881C 080B65A4 */  j     func_802D9690
/* 0FD1D0 802D8820 00000000 */   nop   

/* 0FD1D4 802D8824 4405A000 */  mfc1  $a1, $f20
/* 0FD1D8 802D8828 4406B000 */  mfc1  $a2, $f22
/* 0FD1DC 802D882C 4407C000 */  mfc1  $a3, $f24
/* 0FD1E0 802D8830 0C01C094 */  jal   func_80070250
/* 0FD1E4 802D8834 AFB60010 */   sw    $s6, 0x10($sp)
/* 0FD1E8 802D8838 080B65A4 */  j     func_802D9690
/* 0FD1EC 802D883C 00000000 */   nop   

/* 0FD1F0 802D8840 4405A000 */  mfc1  $a1, $f20
/* 0FD1F4 802D8844 4406B000 */  mfc1  $a2, $f22
/* 0FD1F8 802D8848 4407C000 */  mfc1  $a3, $f24
/* 0FD1FC 802D884C 27A20034 */  addiu $v0, $sp, 0x34
/* 0FD200 802D8850 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD204 802D8854 0C01C0AC */  jal   func_800702B0
/* 0FD208 802D8858 AFA20014 */   sw    $v0, 0x14($sp)
/* 0FD20C 802D885C 080B6337 */  j     func_802D8CDC
/* 0FD210 802D8860 00000000 */   nop   

/* 0FD214 802D8864 4405A000 */  mfc1  $a1, $f20
/* 0FD218 802D8868 4406B000 */  mfc1  $a2, $f22
/* 0FD21C 802D886C 4407C000 */  mfc1  $a3, $f24
/* 0FD220 802D8870 0C01C0C4 */  jal   func_80070310
/* 0FD224 802D8874 AFB60010 */   sw    $s6, 0x10($sp)
/* 0FD228 802D8878 080B65A4 */  j     func_802D9690
/* 0FD22C 802D887C 00000000 */   nop   

/* 0FD230 802D8880 4405A000 */  mfc1  $a1, $f20
/* 0FD234 802D8884 4406B000 */  mfc1  $a2, $f22
/* 0FD238 802D8888 4407C000 */  mfc1  $a3, $f24
/* 0FD23C 802D888C E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD240 802D8890 AFB40014 */  sw    $s4, 0x14($sp)
/* 0FD244 802D8894 E7BE0018 */  swc1  $f30, 0x18($sp)
/* 0FD248 802D8898 0C01C0DC */  jal   func_80070370
/* 0FD24C 802D889C AFB7001C */   sw    $s7, 0x1c($sp)
/* 0FD250 802D88A0 080B65A4 */  j     func_802D9690
/* 0FD254 802D88A4 00000000 */   nop   

/* 0FD258 802D88A8 4405A000 */  mfc1  $a1, $f20
/* 0FD25C 802D88AC 4406B000 */  mfc1  $a2, $f22
/* 0FD260 802D88B0 4407C000 */  mfc1  $a3, $f24
/* 0FD264 802D88B4 8FA30050 */  lw    $v1, 0x50($sp)
/* 0FD268 802D88B8 27A20030 */  addiu $v0, $sp, 0x30
/* 0FD26C 802D88BC E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD270 802D88C0 E7BC0014 */  swc1  $f28, 0x14($sp)
/* 0FD274 802D88C4 AFA2001C */  sw    $v0, 0x1c($sp)
/* 0FD278 802D88C8 0C01C0F4 */  jal   func_800703D0
/* 0FD27C 802D88CC AFA30018 */   sw    $v1, 0x18($sp)
func_802D88D0:
/* 0FD280 802D88D0 8FA400C8 */  lw    $a0, 0xc8($sp)
/* 0FD284 802D88D4 8FA60030 */  lw    $a2, 0x30($sp)
/* 0FD288 802D88D8 0C0B2026 */  jal   func_802C8098
/* 0FD28C 802D88DC 0260282D */   daddu $a1, $s3, $zero
/* 0FD290 802D88E0 080B65A4 */  j     func_802D9690
/* 0FD294 802D88E4 00000000 */   nop   

/* 0FD298 802D88E8 4405A000 */  mfc1  $a1, $f20
/* 0FD29C 802D88EC 4406B000 */  mfc1  $a2, $f22
/* 0FD2A0 802D88F0 4407C000 */  mfc1  $a3, $f24
/* 0FD2A4 802D88F4 C7A2005C */  lwc1  $f2, 0x5c($sp)
/* 0FD2A8 802D88F8 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD2AC 802D88FC E7BC0014 */  swc1  $f28, 0x14($sp)
/* 0FD2B0 802D8900 E7BE0018 */  swc1  $f30, 0x18($sp)
/* 0FD2B4 802D8904 0C01C10C */  jal   func_80070430
/* 0FD2B8 802D8908 E7A2001C */   swc1  $f2, 0x1c($sp)
/* 0FD2BC 802D890C 080B65A4 */  j     func_802D9690
/* 0FD2C0 802D8910 00000000 */   nop   

/* 0FD2C4 802D8914 4405A000 */  mfc1  $a1, $f20
/* 0FD2C8 802D8918 4406B000 */  mfc1  $a2, $f22
/* 0FD2CC 802D891C 4407C000 */  mfc1  $a3, $f24
/* 0FD2D0 802D8920 8FA30050 */  lw    $v1, 0x50($sp)
/* 0FD2D4 802D8924 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD2D8 802D8928 E7BC0014 */  swc1  $f28, 0x14($sp)
/* 0FD2DC 802D892C 0C01C13C */  jal   func_800704F0
/* 0FD2E0 802D8930 AFA30018 */   sw    $v1, 0x18($sp)
/* 0FD2E4 802D8934 080B65A4 */  j     func_802D9690
/* 0FD2E8 802D8938 00000000 */   nop   

/* 0FD2EC 802D893C 4405A000 */  mfc1  $a1, $f20
/* 0FD2F0 802D8940 4406B000 */  mfc1  $a2, $f22
/* 0FD2F4 802D8944 4407C000 */  mfc1  $a3, $f24
/* 0FD2F8 802D8948 8FA30050 */  lw    $v1, 0x50($sp)
/* 0FD2FC 802D894C E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD300 802D8950 E7BC0014 */  swc1  $f28, 0x14($sp)
/* 0FD304 802D8954 AFB7001C */  sw    $s7, 0x1c($sp)
/* 0FD308 802D8958 0C01C154 */  jal   func_80070550
/* 0FD30C 802D895C AFA30018 */   sw    $v1, 0x18($sp)
/* 0FD310 802D8960 080B65A4 */  j     func_802D9690
/* 0FD314 802D8964 00000000 */   nop   

/* 0FD318 802D8968 4405A000 */  mfc1  $a1, $f20
/* 0FD31C 802D896C 4406B000 */  mfc1  $a2, $f22
/* 0FD320 802D8970 4407C000 */  mfc1  $a3, $f24
/* 0FD324 802D8974 0C01C16C */  jal   func_800705B0
/* 0FD328 802D8978 E7BA0010 */   swc1  $f26, 0x10($sp)
/* 0FD32C 802D897C 080B65A4 */  j     func_802D9690
/* 0FD330 802D8980 00000000 */   nop   

/* 0FD334 802D8984 4405A000 */  mfc1  $a1, $f20
/* 0FD338 802D8988 4406B000 */  mfc1  $a2, $f22
/* 0FD33C 802D898C 4407C000 */  mfc1  $a3, $f24
/* 0FD340 802D8990 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD344 802D8994 0C01C184 */  jal   func_80070610
/* 0FD348 802D8998 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FD34C 802D899C 080B65A4 */  j     func_802D9690
/* 0FD350 802D89A0 00000000 */   nop   

/* 0FD354 802D89A4 4405A000 */  mfc1  $a1, $f20
/* 0FD358 802D89A8 4406B000 */  mfc1  $a2, $f22
/* 0FD35C 802D89AC 4407C000 */  mfc1  $a3, $f24
/* 0FD360 802D89B0 0C01C19C */  jal   func_80070670
/* 0FD364 802D89B4 00000000 */   nop   
/* 0FD368 802D89B8 080B65A4 */  j     func_802D9690
/* 0FD36C 802D89BC 00000000 */   nop   

/* 0FD370 802D89C0 4405A000 */  mfc1  $a1, $f20
/* 0FD374 802D89C4 4406B000 */  mfc1  $a2, $f22
/* 0FD378 802D89C8 4407C000 */  mfc1  $a3, $f24
/* 0FD37C 802D89CC 0C01C1B4 */  jal   func_800706D0
/* 0FD380 802D89D0 00000000 */   nop   
/* 0FD384 802D89D4 080B65A4 */  j     func_802D9690
/* 0FD388 802D89D8 00000000 */   nop   

/* 0FD38C 802D89DC 4405A000 */  mfc1  $a1, $f20
/* 0FD390 802D89E0 4406B000 */  mfc1  $a2, $f22
/* 0FD394 802D89E4 4407C000 */  mfc1  $a3, $f24
/* 0FD398 802D89E8 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD39C 802D89EC 0C01C1CC */  jal   func_80070730
/* 0FD3A0 802D89F0 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FD3A4 802D89F4 080B65A4 */  j     func_802D9690
/* 0FD3A8 802D89F8 00000000 */   nop   

/* 0FD3AC 802D89FC 4405A000 */  mfc1  $a1, $f20
/* 0FD3B0 802D8A00 4406B000 */  mfc1  $a2, $f22
/* 0FD3B4 802D8A04 4407C000 */  mfc1  $a3, $f24
/* 0FD3B8 802D8A08 8FA30050 */  lw    $v1, 0x50($sp)
/* 0FD3BC 802D8A0C E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD3C0 802D8A10 E7BC0014 */  swc1  $f28, 0x14($sp)
/* 0FD3C4 802D8A14 0C01C1E4 */  jal   func_80070790
/* 0FD3C8 802D8A18 AFA30018 */   sw    $v1, 0x18($sp)
/* 0FD3CC 802D8A1C 080B65A4 */  j     func_802D9690
/* 0FD3D0 802D8A20 00000000 */   nop   

/* 0FD3D4 802D8A24 4405A000 */  mfc1  $a1, $f20
/* 0FD3D8 802D8A28 4406B000 */  mfc1  $a2, $f22
/* 0FD3DC 802D8A2C 4407C000 */  mfc1  $a3, $f24
/* 0FD3E0 802D8A30 27A20038 */  addiu $v0, $sp, 0x38
/* 0FD3E4 802D8A34 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD3E8 802D8A38 E7BC0014 */  swc1  $f28, 0x14($sp)
/* 0FD3EC 802D8A3C 0C01C1FC */  jal   func_800707F0
/* 0FD3F0 802D8A40 AFA20018 */   sw    $v0, 0x18($sp)
/* 0FD3F4 802D8A44 080B62C2 */  j     func_802D8B08
/* 0FD3F8 802D8A48 00000000 */   nop   

/* 0FD3FC 802D8A4C 4405A000 */  mfc1  $a1, $f20
/* 0FD400 802D8A50 4406B000 */  mfc1  $a2, $f22
/* 0FD404 802D8A54 4407C000 */  mfc1  $a3, $f24
/* 0FD408 802D8A58 0C01C22C */  jal   func_800708B0
/* 0FD40C 802D8A5C 00000000 */   nop   
/* 0FD410 802D8A60 080B65A4 */  j     func_802D9690
/* 0FD414 802D8A64 00000000 */   nop   

/* 0FD418 802D8A68 4405A000 */  mfc1  $a1, $f20
/* 0FD41C 802D8A6C 4406B000 */  mfc1  $a2, $f22
/* 0FD420 802D8A70 4407C000 */  mfc1  $a3, $f24
/* 0FD424 802D8A74 27A20034 */  addiu $v0, $sp, 0x34
/* 0FD428 802D8A78 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD42C 802D8A7C 0C01C124 */  jal   func_80070490
/* 0FD430 802D8A80 AFA20014 */   sw    $v0, 0x14($sp)
/* 0FD434 802D8A84 080B6337 */  j     func_802D8CDC
/* 0FD438 802D8A88 00000000 */   nop   

/* 0FD43C 802D8A8C 4405A000 */  mfc1  $a1, $f20
/* 0FD440 802D8A90 4406B000 */  mfc1  $a2, $f22
/* 0FD444 802D8A94 4407C000 */  mfc1  $a3, $f24
/* 0FD448 802D8A98 0C01C244 */  jal   func_80070910
/* 0FD44C 802D8A9C 00000000 */   nop   
/* 0FD450 802D8AA0 080B65A4 */  j     func_802D9690
/* 0FD454 802D8AA4 00000000 */   nop   

/* 0FD458 802D8AA8 4405A000 */  mfc1  $a1, $f20
/* 0FD45C 802D8AAC 4406B000 */  mfc1  $a2, $f22
/* 0FD460 802D8AB0 4407C000 */  mfc1  $a3, $f24
/* 0FD464 802D8AB4 AFB60010 */  sw    $s6, 0x10($sp)
/* 0FD468 802D8AB8 0C01C25C */  jal   func_80070970
/* 0FD46C 802D8ABC AFB40014 */   sw    $s4, 0x14($sp)
/* 0FD470 802D8AC0 080B65A4 */  j     func_802D9690
/* 0FD474 802D8AC4 00000000 */   nop   

/* 0FD478 802D8AC8 4405A000 */  mfc1  $a1, $f20
/* 0FD47C 802D8ACC 4406B000 */  mfc1  $a2, $f22
/* 0FD480 802D8AD0 4407C000 */  mfc1  $a3, $f24
/* 0FD484 802D8AD4 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD488 802D8AD8 0C01C274 */  jal   func_800709D0
/* 0FD48C 802D8ADC AFB40014 */   sw    $s4, 0x14($sp)
/* 0FD490 802D8AE0 080B65A4 */  j     func_802D9690
/* 0FD494 802D8AE4 00000000 */   nop   

/* 0FD498 802D8AE8 4405A000 */  mfc1  $a1, $f20
/* 0FD49C 802D8AEC 4406B000 */  mfc1  $a2, $f22
/* 0FD4A0 802D8AF0 4407C000 */  mfc1  $a3, $f24
/* 0FD4A4 802D8AF4 27A20038 */  addiu $v0, $sp, 0x38
/* 0FD4A8 802D8AF8 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD4AC 802D8AFC AFB40014 */  sw    $s4, 0x14($sp)
/* 0FD4B0 802D8B00 0C01C28C */  jal   func_80070A30
/* 0FD4B4 802D8B04 AFA20018 */   sw    $v0, 0x18($sp)
func_802D8B08:
/* 0FD4B8 802D8B08 8FA400C8 */  lw    $a0, 0xc8($sp)
/* 0FD4BC 802D8B0C 8FA60038 */  lw    $a2, 0x38($sp)
/* 0FD4C0 802D8B10 0C0B2026 */  jal   func_802C8098
/* 0FD4C4 802D8B14 8FA5006C */   lw    $a1, 0x6c($sp)
/* 0FD4C8 802D8B18 080B65A4 */  j     func_802D9690
/* 0FD4CC 802D8B1C 00000000 */   nop   

/* 0FD4D0 802D8B20 4405A000 */  mfc1  $a1, $f20
/* 0FD4D4 802D8B24 4406B000 */  mfc1  $a2, $f22
/* 0FD4D8 802D8B28 4407C000 */  mfc1  $a3, $f24
/* 0FD4DC 802D8B2C 0C01C2A4 */  jal   func_80070A90
/* 0FD4E0 802D8B30 00000000 */   nop   
/* 0FD4E4 802D8B34 080B65A4 */  j     func_802D9690
/* 0FD4E8 802D8B38 00000000 */   nop   

/* 0FD4EC 802D8B3C 4405A000 */  mfc1  $a1, $f20
/* 0FD4F0 802D8B40 4406B000 */  mfc1  $a2, $f22
/* 0FD4F4 802D8B44 4407C000 */  mfc1  $a3, $f24
/* 0FD4F8 802D8B48 0C01C2BC */  jal   func_80070AF0
/* 0FD4FC 802D8B4C 00000000 */   nop   
/* 0FD500 802D8B50 080B65A4 */  j     func_802D9690
/* 0FD504 802D8B54 00000000 */   nop   

/* 0FD508 802D8B58 4405A000 */  mfc1  $a1, $f20
/* 0FD50C 802D8B5C 4406B000 */  mfc1  $a2, $f22
/* 0FD510 802D8B60 4407C000 */  mfc1  $a3, $f24
/* 0FD514 802D8B64 0C01C2D4 */  jal   func_80070B50
/* 0FD518 802D8B68 E7BA0010 */   swc1  $f26, 0x10($sp)
/* 0FD51C 802D8B6C 080B65A4 */  j     func_802D9690
/* 0FD520 802D8B70 00000000 */   nop   

/* 0FD524 802D8B74 4405A000 */  mfc1  $a1, $f20
/* 0FD528 802D8B78 4406B000 */  mfc1  $a2, $f22
/* 0FD52C 802D8B7C 4407C000 */  mfc1  $a3, $f24
/* 0FD530 802D8B80 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD534 802D8B84 0C01C2EC */  jal   func_80070BB0
/* 0FD538 802D8B88 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FD53C 802D8B8C 080B65A4 */  j     func_802D9690
/* 0FD540 802D8B90 00000000 */   nop   

/* 0FD544 802D8B94 4405A000 */  mfc1  $a1, $f20
/* 0FD548 802D8B98 4406B000 */  mfc1  $a2, $f22
/* 0FD54C 802D8B9C 4407C000 */  mfc1  $a3, $f24
/* 0FD550 802D8BA0 27A20034 */  addiu $v0, $sp, 0x34
/* 0FD554 802D8BA4 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD558 802D8BA8 0C01C304 */  jal   func_80070C10
/* 0FD55C 802D8BAC AFA20014 */   sw    $v0, 0x14($sp)
/* 0FD560 802D8BB0 080B6337 */  j     func_802D8CDC
/* 0FD564 802D8BB4 00000000 */   nop   

/* 0FD568 802D8BB8 4405A000 */  mfc1  $a1, $f20
/* 0FD56C 802D8BBC 4406B000 */  mfc1  $a2, $f22
/* 0FD570 802D8BC0 4407C000 */  mfc1  $a3, $f24
/* 0FD574 802D8BC4 27A20034 */  addiu $v0, $sp, 0x34
/* 0FD578 802D8BC8 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD57C 802D8BCC 0C01C31C */  jal   func_80070C70
/* 0FD580 802D8BD0 AFA20014 */   sw    $v0, 0x14($sp)
/* 0FD584 802D8BD4 080B6337 */  j     func_802D8CDC
/* 0FD588 802D8BD8 00000000 */   nop   

/* 0FD58C 802D8BDC 4405A000 */  mfc1  $a1, $f20
/* 0FD590 802D8BE0 4406B000 */  mfc1  $a2, $f22
/* 0FD594 802D8BE4 4407C000 */  mfc1  $a3, $f24
/* 0FD598 802D8BE8 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD59C 802D8BEC 0C01C334 */  jal   func_80070CD0
/* 0FD5A0 802D8BF0 E7BC0014 */   swc1  $f28, 0x14($sp)
/* 0FD5A4 802D8BF4 080B65A4 */  j     func_802D9690
/* 0FD5A8 802D8BF8 0040A82D */   daddu $s5, $v0, $zero

/* 0FD5AC 802D8BFC 4405A000 */  mfc1  $a1, $f20
/* 0FD5B0 802D8C00 4406B000 */  mfc1  $a2, $f22
/* 0FD5B4 802D8C04 4407C000 */  mfc1  $a3, $f24
/* 0FD5B8 802D8C08 8FA30054 */  lw    $v1, 0x54($sp)
/* 0FD5BC 802D8C0C E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD5C0 802D8C10 E7BC0014 */  swc1  $f28, 0x14($sp)
/* 0FD5C4 802D8C14 E7BE0018 */  swc1  $f30, 0x18($sp)
/* 0FD5C8 802D8C18 AFB7001C */  sw    $s7, 0x1c($sp)
/* 0FD5CC 802D8C1C AFBE0020 */  sw    $fp, 0x20($sp)
/* 0FD5D0 802D8C20 0C01C34C */  jal   func_80070D30
/* 0FD5D4 802D8C24 AFA30024 */   sw    $v1, 0x24($sp)
/* 0FD5D8 802D8C28 080B65A4 */  j     func_802D9690
/* 0FD5DC 802D8C2C 0040A82D */   daddu $s5, $v0, $zero

/* 0FD5E0 802D8C30 4405A000 */  mfc1  $a1, $f20
/* 0FD5E4 802D8C34 4406B000 */  mfc1  $a2, $f22
/* 0FD5E8 802D8C38 4407C000 */  mfc1  $a3, $f24
/* 0FD5EC 802D8C3C E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD5F0 802D8C40 0C01C364 */  jal   func_80070D90
/* 0FD5F4 802D8C44 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FD5F8 802D8C48 080B65A4 */  j     func_802D9690
/* 0FD5FC 802D8C4C 00000000 */   nop   

/* 0FD600 802D8C50 4405A000 */  mfc1  $a1, $f20
/* 0FD604 802D8C54 4406B000 */  mfc1  $a2, $f22
/* 0FD608 802D8C58 4407C000 */  mfc1  $a3, $f24
/* 0FD60C 802D8C5C E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD610 802D8C60 0C01C37C */  jal   func_80070DF0
/* 0FD614 802D8C64 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FD618 802D8C68 080B65A4 */  j     func_802D9690
/* 0FD61C 802D8C6C 00000000 */   nop   

/* 0FD620 802D8C70 4405A000 */  mfc1  $a1, $f20
/* 0FD624 802D8C74 4406B000 */  mfc1  $a2, $f22
/* 0FD628 802D8C78 4407C000 */  mfc1  $a3, $f24
/* 0FD62C 802D8C7C 8FA30050 */  lw    $v1, 0x50($sp)
/* 0FD630 802D8C80 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD634 802D8C84 E7BC0014 */  swc1  $f28, 0x14($sp)
/* 0FD638 802D8C88 AFB7001C */  sw    $s7, 0x1c($sp)
/* 0FD63C 802D8C8C 0C01C394 */  jal   func_80070E50
/* 0FD640 802D8C90 AFA30018 */   sw    $v1, 0x18($sp)
/* 0FD644 802D8C94 080B65A4 */  j     func_802D9690
/* 0FD648 802D8C98 00000000 */   nop   

/* 0FD64C 802D8C9C 4405A000 */  mfc1  $a1, $f20
/* 0FD650 802D8CA0 4406B000 */  mfc1  $a2, $f22
/* 0FD654 802D8CA4 4407C000 */  mfc1  $a3, $f24
/* 0FD658 802D8CA8 27A20034 */  addiu $v0, $sp, 0x34
/* 0FD65C 802D8CAC E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD660 802D8CB0 0C01C3AC */  jal   func_80070EB0
/* 0FD664 802D8CB4 AFA20014 */   sw    $v0, 0x14($sp)
/* 0FD668 802D8CB8 080B6337 */  j     func_802D8CDC
/* 0FD66C 802D8CBC 00000000 */   nop   

/* 0FD670 802D8CC0 4405A000 */  mfc1  $a1, $f20
/* 0FD674 802D8CC4 4406B000 */  mfc1  $a2, $f22
/* 0FD678 802D8CC8 4407C000 */  mfc1  $a3, $f24
/* 0FD67C 802D8CCC 27A20034 */  addiu $v0, $sp, 0x34
/* 0FD680 802D8CD0 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD684 802D8CD4 0C01C3C4 */  jal   func_80070F10
/* 0FD688 802D8CD8 AFA20014 */   sw    $v0, 0x14($sp)
func_802D8CDC:
/* 0FD68C 802D8CDC 8FA400C8 */  lw    $a0, 0xc8($sp)
/* 0FD690 802D8CE0 8FA60034 */  lw    $a2, 0x34($sp)
/* 0FD694 802D8CE4 0C0B2026 */  jal   func_802C8098
/* 0FD698 802D8CE8 0200282D */   daddu $a1, $s0, $zero
/* 0FD69C 802D8CEC 080B65A4 */  j     func_802D9690
/* 0FD6A0 802D8CF0 00000000 */   nop   

/* 0FD6A4 802D8CF4 4405A000 */  mfc1  $a1, $f20
/* 0FD6A8 802D8CF8 4406B000 */  mfc1  $a2, $f22
/* 0FD6AC 802D8CFC 4407C000 */  mfc1  $a3, $f24
/* 0FD6B0 802D8D00 27A2003C */  addiu $v0, $sp, 0x3c
/* 0FD6B4 802D8D04 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD6B8 802D8D08 E7BC0014 */  swc1  $f28, 0x14($sp)
/* 0FD6BC 802D8D0C E7BE0018 */  swc1  $f30, 0x18($sp)
/* 0FD6C0 802D8D10 AFB7001C */  sw    $s7, 0x1c($sp)
/* 0FD6C4 802D8D14 0C01C3DC */  jal   func_80070F70
/* 0FD6C8 802D8D18 AFA20020 */   sw    $v0, 0x20($sp)
/* 0FD6CC 802D8D1C 8FA400C8 */  lw    $a0, 0xc8($sp)
/* 0FD6D0 802D8D20 8FA6003C */  lw    $a2, 0x3c($sp)
/* 0FD6D4 802D8D24 0C0B2026 */  jal   func_802C8098
/* 0FD6D8 802D8D28 0220282D */   daddu $a1, $s1, $zero
/* 0FD6DC 802D8D2C 080B65A4 */  j     func_802D9690
/* 0FD6E0 802D8D30 00000000 */   nop   

/* 0FD6E4 802D8D34 4405A000 */  mfc1  $a1, $f20
/* 0FD6E8 802D8D38 4406B000 */  mfc1  $a2, $f22
/* 0FD6EC 802D8D3C 4407C000 */  mfc1  $a3, $f24
/* 0FD6F0 802D8D40 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD6F4 802D8D44 0C01C3F4 */  jal   func_80070FD0
/* 0FD6F8 802D8D48 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FD6FC 802D8D4C 080B65A4 */  j     func_802D9690
/* 0FD700 802D8D50 00000000 */   nop   

/* 0FD704 802D8D54 4405A000 */  mfc1  $a1, $f20
/* 0FD708 802D8D58 4406B000 */  mfc1  $a2, $f22
/* 0FD70C 802D8D5C 4407C000 */  mfc1  $a3, $f24
/* 0FD710 802D8D60 0C01C40C */  jal   func_80071030
/* 0FD714 802D8D64 AFB60010 */   sw    $s6, 0x10($sp)
/* 0FD718 802D8D68 080B65A4 */  j     func_802D9690
/* 0FD71C 802D8D6C 0040A82D */   daddu $s5, $v0, $zero

/* 0FD720 802D8D70 4405A000 */  mfc1  $a1, $f20
/* 0FD724 802D8D74 4406B000 */  mfc1  $a2, $f22
/* 0FD728 802D8D78 4407C000 */  mfc1  $a3, $f24
/* 0FD72C 802D8D7C 0C01C424 */  jal   func_80071090
/* 0FD730 802D8D80 AFB60010 */   sw    $s6, 0x10($sp)
/* 0FD734 802D8D84 080B65A4 */  j     func_802D9690
/* 0FD738 802D8D88 0040A82D */   daddu $s5, $v0, $zero

/* 0FD73C 802D8D8C 4405A000 */  mfc1  $a1, $f20
/* 0FD740 802D8D90 4406B000 */  mfc1  $a2, $f22
/* 0FD744 802D8D94 4407C000 */  mfc1  $a3, $f24
/* 0FD748 802D8D98 0C01C43C */  jal   func_800710F0
/* 0FD74C 802D8D9C AFB60010 */   sw    $s6, 0x10($sp)
/* 0FD750 802D8DA0 080B65A4 */  j     func_802D9690
/* 0FD754 802D8DA4 0040A82D */   daddu $s5, $v0, $zero

/* 0FD758 802D8DA8 8FA50044 */  lw    $a1, 0x44($sp)
/* 0FD75C 802D8DAC 4407C000 */  mfc1  $a3, $f24
/* 0FD760 802D8DB0 8FA60048 */  lw    $a2, 0x48($sp)
/* 0FD764 802D8DB4 AFB60010 */  sw    $s6, 0x10($sp)
/* 0FD768 802D8DB8 0C01C454 */  jal   func_80071150
/* 0FD76C 802D8DBC AFB40014 */   sw    $s4, 0x14($sp)
/* 0FD770 802D8DC0 080B65A4 */  j     func_802D9690
/* 0FD774 802D8DC4 0040A82D */   daddu $s5, $v0, $zero

/* 0FD778 802D8DC8 4405A000 */  mfc1  $a1, $f20
/* 0FD77C 802D8DCC 4406B000 */  mfc1  $a2, $f22
/* 0FD780 802D8DD0 4407C000 */  mfc1  $a3, $f24
/* 0FD784 802D8DD4 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD788 802D8DD8 0C01C46C */  jal   func_800711B0
/* 0FD78C 802D8DDC AFB40014 */   sw    $s4, 0x14($sp)
/* 0FD790 802D8DE0 080B65A4 */  j     func_802D9690
/* 0FD794 802D8DE4 0040A82D */   daddu $s5, $v0, $zero

/* 0FD798 802D8DE8 4405A000 */  mfc1  $a1, $f20
/* 0FD79C 802D8DEC 4406B000 */  mfc1  $a2, $f22
/* 0FD7A0 802D8DF0 4407C000 */  mfc1  $a3, $f24
/* 0FD7A4 802D8DF4 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD7A8 802D8DF8 0C01C484 */  jal   func_80071210
/* 0FD7AC 802D8DFC AFB40014 */   sw    $s4, 0x14($sp)
/* 0FD7B0 802D8E00 080B65A4 */  j     func_802D9690
/* 0FD7B4 802D8E04 0040A82D */   daddu $s5, $v0, $zero

/* 0FD7B8 802D8E08 8FA50044 */  lw    $a1, 0x44($sp)
/* 0FD7BC 802D8E0C 0C01C49C */  jal   func_80071270
/* 0FD7C0 802D8E10 00000000 */   nop   
/* 0FD7C4 802D8E14 080B65A4 */  j     func_802D9690
/* 0FD7C8 802D8E18 0040A82D */   daddu $s5, $v0, $zero

/* 0FD7CC 802D8E1C 4406B000 */  mfc1  $a2, $f22
/* 0FD7D0 802D8E20 0C01C4B4 */  jal   func_800712D0
/* 0FD7D4 802D8E24 8FA7004C */   lw    $a3, 0x4c($sp)
/* 0FD7D8 802D8E28 080B65A4 */  j     func_802D9690
/* 0FD7DC 802D8E2C 0040A82D */   daddu $s5, $v0, $zero

/* 0FD7E0 802D8E30 4405A000 */  mfc1  $a1, $f20
/* 0FD7E4 802D8E34 4406B000 */  mfc1  $a2, $f22
/* 0FD7E8 802D8E38 4407C000 */  mfc1  $a3, $f24
/* 0FD7EC 802D8E3C E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD7F0 802D8E40 0C01C4CC */  jal   func_80071330
/* 0FD7F4 802D8E44 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FD7F8 802D8E48 080B65A4 */  j     func_802D9690
/* 0FD7FC 802D8E4C 0040A82D */   daddu $s5, $v0, $zero

/* 0FD800 802D8E50 4405A000 */  mfc1  $a1, $f20
/* 0FD804 802D8E54 4406B000 */  mfc1  $a2, $f22
/* 0FD808 802D8E58 4407C000 */  mfc1  $a3, $f24
/* 0FD80C 802D8E5C E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD810 802D8E60 0C01C4E4 */  jal   func_80071390
/* 0FD814 802D8E64 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FD818 802D8E68 080B65A4 */  j     func_802D9690
/* 0FD81C 802D8E6C 0040A82D */   daddu $s5, $v0, $zero

/* 0FD820 802D8E70 4405A000 */  mfc1  $a1, $f20
/* 0FD824 802D8E74 4406B000 */  mfc1  $a2, $f22
/* 0FD828 802D8E78 4407C000 */  mfc1  $a3, $f24
/* 0FD82C 802D8E7C E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD830 802D8E80 0C01C4FC */  jal   func_800713F0
/* 0FD834 802D8E84 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FD838 802D8E88 080B65A4 */  j     func_802D9690
/* 0FD83C 802D8E8C 0040A82D */   daddu $s5, $v0, $zero

/* 0FD840 802D8E90 4405A000 */  mfc1  $a1, $f20
/* 0FD844 802D8E94 4406B000 */  mfc1  $a2, $f22
/* 0FD848 802D8E98 4407C000 */  mfc1  $a3, $f24
/* 0FD84C 802D8E9C E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD850 802D8EA0 0C01C514 */  jal   func_80071450
/* 0FD854 802D8EA4 E7BC0014 */   swc1  $f28, 0x14($sp)
/* 0FD858 802D8EA8 080B65A4 */  j     func_802D9690
/* 0FD85C 802D8EAC 0040A82D */   daddu $s5, $v0, $zero

/* 0FD860 802D8EB0 4405A000 */  mfc1  $a1, $f20
/* 0FD864 802D8EB4 4406B000 */  mfc1  $a2, $f22
/* 0FD868 802D8EB8 4407C000 */  mfc1  $a3, $f24
/* 0FD86C 802D8EBC E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD870 802D8EC0 0C01C52C */  jal   func_800714B0
/* 0FD874 802D8EC4 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FD878 802D8EC8 080B65A4 */  j     func_802D9690
/* 0FD87C 802D8ECC 0040A82D */   daddu $s5, $v0, $zero

/* 0FD880 802D8ED0 4405A000 */  mfc1  $a1, $f20
/* 0FD884 802D8ED4 4406B000 */  mfc1  $a2, $f22
/* 0FD888 802D8ED8 4407C000 */  mfc1  $a3, $f24
/* 0FD88C 802D8EDC C7A2005C */  lwc1  $f2, 0x5c($sp)
/* 0FD890 802D8EE0 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD894 802D8EE4 E7BC0014 */  swc1  $f28, 0x14($sp)
/* 0FD898 802D8EE8 E7BE0018 */  swc1  $f30, 0x18($sp)
/* 0FD89C 802D8EEC AFBE0020 */  sw    $fp, 0x20($sp)
/* 0FD8A0 802D8EF0 0C01C544 */  jal   func_80071510
/* 0FD8A4 802D8EF4 E7A2001C */   swc1  $f2, 0x1c($sp)
/* 0FD8A8 802D8EF8 080B65A4 */  j     func_802D9690
/* 0FD8AC 802D8EFC 0040A82D */   daddu $s5, $v0, $zero

/* 0FD8B0 802D8F00 4600E08D */  trunc.w.s $f2, $f28
/* 0FD8B4 802D8F04 E7A20014 */  swc1  $f2, 0x14($sp)
/* 0FD8B8 802D8F08 C7A2005C */  lwc1  $f2, 0x5c($sp)
/* 0FD8BC 802D8F0C 4405A000 */  mfc1  $a1, $f20
/* 0FD8C0 802D8F10 4406B000 */  mfc1  $a2, $f22
/* 0FD8C4 802D8F14 4407C000 */  mfc1  $a3, $f24
/* 0FD8C8 802D8F18 4600108D */  trunc.w.s $f2, $f2
/* 0FD8CC 802D8F1C E7A2001C */  swc1  $f2, 0x1c($sp)
/* 0FD8D0 802D8F20 C7A20060 */  lwc1  $f2, 0x60($sp)
/* 0FD8D4 802D8F24 8FA30054 */  lw    $v1, 0x54($sp)
/* 0FD8D8 802D8F28 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD8DC 802D8F2C E7BE0018 */  swc1  $f30, 0x18($sp)
/* 0FD8E0 802D8F30 E7A20020 */  swc1  $f2, 0x20($sp)
/* 0FD8E4 802D8F34 0C01C55C */  jal   func_80071570
/* 0FD8E8 802D8F38 AFA30024 */   sw    $v1, 0x24($sp)
/* 0FD8EC 802D8F3C 080B65A4 */  j     func_802D9690
/* 0FD8F0 802D8F40 0040A82D */   daddu $s5, $v0, $zero

/* 0FD8F4 802D8F44 4405A000 */  mfc1  $a1, $f20
/* 0FD8F8 802D8F48 4406B000 */  mfc1  $a2, $f22
/* 0FD8FC 802D8F4C 4407C000 */  mfc1  $a3, $f24
/* 0FD900 802D8F50 0C01C574 */  jal   func_800715D0
/* 0FD904 802D8F54 00000000 */   nop   
/* 0FD908 802D8F58 080B65A4 */  j     func_802D9690
/* 0FD90C 802D8F5C 0040A82D */   daddu $s5, $v0, $zero

/* 0FD910 802D8F60 4405A000 */  mfc1  $a1, $f20
/* 0FD914 802D8F64 4406B000 */  mfc1  $a2, $f22
/* 0FD918 802D8F68 4407C000 */  mfc1  $a3, $f24
/* 0FD91C 802D8F6C E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD920 802D8F70 0C01C58C */  jal   func_80071630
/* 0FD924 802D8F74 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FD928 802D8F78 080B65A4 */  j     func_802D9690
/* 0FD92C 802D8F7C 0040A82D */   daddu $s5, $v0, $zero

/* 0FD930 802D8F80 4405A000 */  mfc1  $a1, $f20
/* 0FD934 802D8F84 4406B000 */  mfc1  $a2, $f22
/* 0FD938 802D8F88 4407C000 */  mfc1  $a3, $f24
/* 0FD93C 802D8F8C E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD940 802D8F90 0C01C5D4 */  jal   func_80071750
/* 0FD944 802D8F94 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FD948 802D8F98 080B65A4 */  j     func_802D9690
/* 0FD94C 802D8F9C 0040A82D */   daddu $s5, $v0, $zero

/* 0FD950 802D8FA0 4405A000 */  mfc1  $a1, $f20
/* 0FD954 802D8FA4 4406B000 */  mfc1  $a2, $f22
/* 0FD958 802D8FA8 4407C000 */  mfc1  $a3, $f24
/* 0FD95C 802D8FAC 0C01C5EC */  jal   func_800717B0
/* 0FD960 802D8FB0 00000000 */   nop   
/* 0FD964 802D8FB4 080B65A4 */  j     func_802D9690
/* 0FD968 802D8FB8 0040A82D */   daddu $s5, $v0, $zero

/* 0FD96C 802D8FBC 4405A000 */  mfc1  $a1, $f20
/* 0FD970 802D8FC0 4406B000 */  mfc1  $a2, $f22
/* 0FD974 802D8FC4 4407C000 */  mfc1  $a3, $f24
/* 0FD978 802D8FC8 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD97C 802D8FCC 0C01C5BC */  jal   func_800716F0
/* 0FD980 802D8FD0 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FD984 802D8FD4 080B65A4 */  j     func_802D9690
/* 0FD988 802D8FD8 0040A82D */   daddu $s5, $v0, $zero

/* 0FD98C 802D8FDC 4405A000 */  mfc1  $a1, $f20
/* 0FD990 802D8FE0 4406B000 */  mfc1  $a2, $f22
/* 0FD994 802D8FE4 4407C000 */  mfc1  $a3, $f24
/* 0FD998 802D8FE8 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD99C 802D8FEC 0C01C634 */  jal   func_800718D0
/* 0FD9A0 802D8FF0 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FD9A4 802D8FF4 080B65A4 */  j     func_802D9690
/* 0FD9A8 802D8FF8 0040A82D */   daddu $s5, $v0, $zero

/* 0FD9AC 802D8FFC 4405A000 */  mfc1  $a1, $f20
/* 0FD9B0 802D9000 4406B000 */  mfc1  $a2, $f22
/* 0FD9B4 802D9004 4407C000 */  mfc1  $a3, $f24
/* 0FD9B8 802D9008 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD9BC 802D900C 0C01C64C */  jal   func_80071930
/* 0FD9C0 802D9010 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FD9C4 802D9014 080B65A4 */  j     func_802D9690
/* 0FD9C8 802D9018 0040A82D */   daddu $s5, $v0, $zero

/* 0FD9CC 802D901C 4405A000 */  mfc1  $a1, $f20
/* 0FD9D0 802D9020 4406B000 */  mfc1  $a2, $f22
/* 0FD9D4 802D9024 4407C000 */  mfc1  $a3, $f24
/* 0FD9D8 802D9028 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FD9DC 802D902C 0C01C664 */  jal   func_80071990
/* 0FD9E0 802D9030 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FD9E4 802D9034 080B65A4 */  j     func_802D9690
/* 0FD9E8 802D9038 0040A82D */   daddu $s5, $v0, $zero

/* 0FD9EC 802D903C 4405A000 */  mfc1  $a1, $f20
/* 0FD9F0 802D9040 4406B000 */  mfc1  $a2, $f22
/* 0FD9F4 802D9044 4407C000 */  mfc1  $a3, $f24
/* 0FD9F8 802D9048 C7A2005C */  lwc1  $f2, 0x5c($sp)
/* 0FD9FC 802D904C E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDA00 802D9050 E7BC0014 */  swc1  $f28, 0x14($sp)
/* 0FDA04 802D9054 E7BE0018 */  swc1  $f30, 0x18($sp)
/* 0FDA08 802D9058 AFBE0020 */  sw    $fp, 0x20($sp)
/* 0FDA0C 802D905C 0C01C67C */  jal   func_800719F0
/* 0FDA10 802D9060 E7A2001C */   swc1  $f2, 0x1c($sp)
/* 0FDA14 802D9064 080B65A4 */  j     func_802D9690
/* 0FDA18 802D9068 0040A82D */   daddu $s5, $v0, $zero

/* 0FDA1C 802D906C 4405A000 */  mfc1  $a1, $f20
/* 0FDA20 802D9070 4406B000 */  mfc1  $a2, $f22
/* 0FDA24 802D9074 4407C000 */  mfc1  $a3, $f24
/* 0FDA28 802D9078 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDA2C 802D907C 0C01C694 */  jal   func_80071A50
/* 0FDA30 802D9080 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FDA34 802D9084 080B65A4 */  j     func_802D9690
/* 0FDA38 802D9088 0040A82D */   daddu $s5, $v0, $zero

/* 0FDA3C 802D908C 4405A000 */  mfc1  $a1, $f20
/* 0FDA40 802D9090 4406B000 */  mfc1  $a2, $f22
/* 0FDA44 802D9094 4407C000 */  mfc1  $a3, $f24
/* 0FDA48 802D9098 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDA4C 802D909C 0C01C6AC */  jal   func_80071AB0
/* 0FDA50 802D90A0 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FDA54 802D90A4 080B65A4 */  j     func_802D9690
/* 0FDA58 802D90A8 0040A82D */   daddu $s5, $v0, $zero

/* 0FDA5C 802D90AC 4405A000 */  mfc1  $a1, $f20
/* 0FDA60 802D90B0 4406B000 */  mfc1  $a2, $f22
/* 0FDA64 802D90B4 4407C000 */  mfc1  $a3, $f24
/* 0FDA68 802D90B8 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDA6C 802D90BC 0C01C6C4 */  jal   func_80071B10
/* 0FDA70 802D90C0 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FDA74 802D90C4 080B65A4 */  j     func_802D9690
/* 0FDA78 802D90C8 0040A82D */   daddu $s5, $v0, $zero

/* 0FDA7C 802D90CC 4405A000 */  mfc1  $a1, $f20
/* 0FDA80 802D90D0 4406B000 */  mfc1  $a2, $f22
/* 0FDA84 802D90D4 4407C000 */  mfc1  $a3, $f24
/* 0FDA88 802D90D8 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDA8C 802D90DC 0C01C6DC */  jal   func_80071B70
/* 0FDA90 802D90E0 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FDA94 802D90E4 080B65A4 */  j     func_802D9690
/* 0FDA98 802D90E8 0040A82D */   daddu $s5, $v0, $zero

/* 0FDA9C 802D90EC 4405A000 */  mfc1  $a1, $f20
/* 0FDAA0 802D90F0 4406B000 */  mfc1  $a2, $f22
/* 0FDAA4 802D90F4 4407C000 */  mfc1  $a3, $f24
/* 0FDAA8 802D90F8 C7A2005C */  lwc1  $f2, 0x5c($sp)
/* 0FDAAC 802D90FC E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDAB0 802D9100 E7BC0014 */  swc1  $f28, 0x14($sp)
/* 0FDAB4 802D9104 E7BE0018 */  swc1  $f30, 0x18($sp)
/* 0FDAB8 802D9108 AFBE0020 */  sw    $fp, 0x20($sp)
/* 0FDABC 802D910C 0C01C6F4 */  jal   func_80071BD0
/* 0FDAC0 802D9110 E7A2001C */   swc1  $f2, 0x1c($sp)
/* 0FDAC4 802D9114 080B65A4 */  j     func_802D9690
/* 0FDAC8 802D9118 0040A82D */   daddu $s5, $v0, $zero

/* 0FDACC 802D911C 4405A000 */  mfc1  $a1, $f20
/* 0FDAD0 802D9120 4406B000 */  mfc1  $a2, $f22
/* 0FDAD4 802D9124 4407C000 */  mfc1  $a3, $f24
/* 0FDAD8 802D9128 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDADC 802D912C 0C01C70C */  jal   func_80071C30
/* 0FDAE0 802D9130 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FDAE4 802D9134 080B65A4 */  j     func_802D9690
/* 0FDAE8 802D9138 0040A82D */   daddu $s5, $v0, $zero

/* 0FDAEC 802D913C 4405A000 */  mfc1  $a1, $f20
/* 0FDAF0 802D9140 4406B000 */  mfc1  $a2, $f22
/* 0FDAF4 802D9144 4407C000 */  mfc1  $a3, $f24
/* 0FDAF8 802D9148 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDAFC 802D914C 0C01C724 */  jal   func_80071C90
/* 0FDB00 802D9150 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FDB04 802D9154 080B65A4 */  j     func_802D9690
/* 0FDB08 802D9158 0040A82D */   daddu $s5, $v0, $zero

/* 0FDB0C 802D915C 4405A000 */  mfc1  $a1, $f20
/* 0FDB10 802D9160 4406B000 */  mfc1  $a2, $f22
/* 0FDB14 802D9164 4407C000 */  mfc1  $a3, $f24
/* 0FDB18 802D9168 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDB1C 802D916C 0C01C73C */  jal   func_80071CF0
/* 0FDB20 802D9170 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FDB24 802D9174 080B65A4 */  j     func_802D9690
/* 0FDB28 802D9178 0040A82D */   daddu $s5, $v0, $zero

/* 0FDB2C 802D917C 4405A000 */  mfc1  $a1, $f20
/* 0FDB30 802D9180 4406B000 */  mfc1  $a2, $f22
/* 0FDB34 802D9184 4407C000 */  mfc1  $a3, $f24
/* 0FDB38 802D9188 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDB3C 802D918C 0C01C754 */  jal   func_80071D50
/* 0FDB40 802D9190 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FDB44 802D9194 080B65A4 */  j     func_802D9690
/* 0FDB48 802D9198 0040A82D */   daddu $s5, $v0, $zero

/* 0FDB4C 802D919C 4405A000 */  mfc1  $a1, $f20
/* 0FDB50 802D91A0 4406B000 */  mfc1  $a2, $f22
/* 0FDB54 802D91A4 4407C000 */  mfc1  $a3, $f24
/* 0FDB58 802D91A8 C7A2005C */  lwc1  $f2, 0x5c($sp)
/* 0FDB5C 802D91AC 8FA30054 */  lw    $v1, 0x54($sp)
/* 0FDB60 802D91B0 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDB64 802D91B4 E7BC0014 */  swc1  $f28, 0x14($sp)
/* 0FDB68 802D91B8 E7BE0018 */  swc1  $f30, 0x18($sp)
/* 0FDB6C 802D91BC AFBE0020 */  sw    $fp, 0x20($sp)
/* 0FDB70 802D91C0 E7A2001C */  swc1  $f2, 0x1c($sp)
/* 0FDB74 802D91C4 0C01C76C */  jal   func_80071DB0
/* 0FDB78 802D91C8 AFA30024 */   sw    $v1, 0x24($sp)
/* 0FDB7C 802D91CC 080B65A4 */  j     func_802D9690
/* 0FDB80 802D91D0 0040A82D */   daddu $s5, $v0, $zero

/* 0FDB84 802D91D4 4405A000 */  mfc1  $a1, $f20
/* 0FDB88 802D91D8 4406B000 */  mfc1  $a2, $f22
/* 0FDB8C 802D91DC 4407C000 */  mfc1  $a3, $f24
/* 0FDB90 802D91E0 C7A2005C */  lwc1  $f2, 0x5c($sp)
/* 0FDB94 802D91E4 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDB98 802D91E8 E7BC0014 */  swc1  $f28, 0x14($sp)
/* 0FDB9C 802D91EC E7BE0018 */  swc1  $f30, 0x18($sp)
/* 0FDBA0 802D91F0 AFBE0020 */  sw    $fp, 0x20($sp)
/* 0FDBA4 802D91F4 0C01C784 */  jal   func_80071E10
/* 0FDBA8 802D91F8 E7A2001C */   swc1  $f2, 0x1c($sp)
/* 0FDBAC 802D91FC 080B65A4 */  j     func_802D9690
/* 0FDBB0 802D9200 0040A82D */   daddu $s5, $v0, $zero

/* 0FDBB4 802D9204 4405A000 */  mfc1  $a1, $f20
/* 0FDBB8 802D9208 4406B000 */  mfc1  $a2, $f22
/* 0FDBBC 802D920C 4407C000 */  mfc1  $a3, $f24
/* 0FDBC0 802D9210 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDBC4 802D9214 0C01C79C */  jal   func_80071E70
/* 0FDBC8 802D9218 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FDBCC 802D921C 080B65A4 */  j     func_802D9690
/* 0FDBD0 802D9220 0040A82D */   daddu $s5, $v0, $zero

/* 0FDBD4 802D9224 4405A000 */  mfc1  $a1, $f20
/* 0FDBD8 802D9228 4406B000 */  mfc1  $a2, $f22
/* 0FDBDC 802D922C 4407C000 */  mfc1  $a3, $f24
/* 0FDBE0 802D9230 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDBE4 802D9234 0C01C7B4 */  jal   func_80071ED0
/* 0FDBE8 802D9238 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FDBEC 802D923C 080B65A4 */  j     func_802D9690
/* 0FDBF0 802D9240 0040A82D */   daddu $s5, $v0, $zero

/* 0FDBF4 802D9244 4405A000 */  mfc1  $a1, $f20
/* 0FDBF8 802D9248 4406B000 */  mfc1  $a2, $f22
/* 0FDBFC 802D924C 4407C000 */  mfc1  $a3, $f24
/* 0FDC00 802D9250 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDC04 802D9254 0C01C7CC */  jal   func_80071F30
/* 0FDC08 802D9258 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FDC0C 802D925C 080B65A4 */  j     func_802D9690
/* 0FDC10 802D9260 0040A82D */   daddu $s5, $v0, $zero

/* 0FDC14 802D9264 4405A000 */  mfc1  $a1, $f20
/* 0FDC18 802D9268 4406B000 */  mfc1  $a2, $f22
/* 0FDC1C 802D926C 4407C000 */  mfc1  $a3, $f24
/* 0FDC20 802D9270 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDC24 802D9274 0C01C7E4 */  jal   func_80071F90
/* 0FDC28 802D9278 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FDC2C 802D927C 080B65A4 */  j     func_802D9690
/* 0FDC30 802D9280 0040A82D */   daddu $s5, $v0, $zero

/* 0FDC34 802D9284 4405A000 */  mfc1  $a1, $f20
/* 0FDC38 802D9288 4406B000 */  mfc1  $a2, $f22
/* 0FDC3C 802D928C 4407C000 */  mfc1  $a3, $f24
/* 0FDC40 802D9290 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDC44 802D9294 0C01C7FC */  jal   func_80071FF0
/* 0FDC48 802D9298 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FDC4C 802D929C 080B65A4 */  j     func_802D9690
/* 0FDC50 802D92A0 0040A82D */   daddu $s5, $v0, $zero

/* 0FDC54 802D92A4 4405A000 */  mfc1  $a1, $f20
/* 0FDC58 802D92A8 4406B000 */  mfc1  $a2, $f22
/* 0FDC5C 802D92AC 4407C000 */  mfc1  $a3, $f24
/* 0FDC60 802D92B0 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDC64 802D92B4 0C01C82C */  jal   func_800720B0
/* 0FDC68 802D92B8 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FDC6C 802D92BC 080B65A4 */  j     func_802D9690
/* 0FDC70 802D92C0 0040A82D */   daddu $s5, $v0, $zero

/* 0FDC74 802D92C4 4405A000 */  mfc1  $a1, $f20
/* 0FDC78 802D92C8 4406B000 */  mfc1  $a2, $f22
/* 0FDC7C 802D92CC 4407C000 */  mfc1  $a3, $f24
/* 0FDC80 802D92D0 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDC84 802D92D4 0C01C844 */  jal   func_80072110
/* 0FDC88 802D92D8 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FDC8C 802D92DC 080B65A4 */  j     func_802D9690
/* 0FDC90 802D92E0 0040A82D */   daddu $s5, $v0, $zero

/* 0FDC94 802D92E4 4405A000 */  mfc1  $a1, $f20
/* 0FDC98 802D92E8 4406B000 */  mfc1  $a2, $f22
/* 0FDC9C 802D92EC 4407C000 */  mfc1  $a3, $f24
/* 0FDCA0 802D92F0 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDCA4 802D92F4 0C01C85C */  jal   func_80072170
/* 0FDCA8 802D92F8 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FDCAC 802D92FC 080B65A4 */  j     func_802D9690
/* 0FDCB0 802D9300 0040A82D */   daddu $s5, $v0, $zero

/* 0FDCB4 802D9304 4405A000 */  mfc1  $a1, $f20
/* 0FDCB8 802D9308 4406B000 */  mfc1  $a2, $f22
/* 0FDCBC 802D930C 4407C000 */  mfc1  $a3, $f24
/* 0FDCC0 802D9310 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDCC4 802D9314 E7BC0014 */  swc1  $f28, 0x14($sp)
/* 0FDCC8 802D9318 E7BE0018 */  swc1  $f30, 0x18($sp)
/* 0FDCCC 802D931C 0C01C874 */  jal   func_800721D0
/* 0FDCD0 802D9320 AFB7001C */   sw    $s7, 0x1c($sp)
/* 0FDCD4 802D9324 080B65A4 */  j     func_802D9690
/* 0FDCD8 802D9328 0040A82D */   daddu $s5, $v0, $zero

/* 0FDCDC 802D932C 4405A000 */  mfc1  $a1, $f20
/* 0FDCE0 802D9330 4406B000 */  mfc1  $a2, $f22
/* 0FDCE4 802D9334 4407C000 */  mfc1  $a3, $f24
/* 0FDCE8 802D9338 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDCEC 802D933C 0C01C88C */  jal   func_80072230
/* 0FDCF0 802D9340 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FDCF4 802D9344 080B65A4 */  j     func_802D9690
/* 0FDCF8 802D9348 0040A82D */   daddu $s5, $v0, $zero

/* 0FDCFC 802D934C C7A20064 */  lwc1  $f2, 0x64($sp)
/* 0FDD00 802D9350 4405A000 */  mfc1  $a1, $f20
/* 0FDD04 802D9354 4406B000 */  mfc1  $a2, $f22
/* 0FDD08 802D9358 4407C000 */  mfc1  $a3, $f24
/* 0FDD0C 802D935C E7A20024 */  swc1  $f2, 0x24($sp)
/* 0FDD10 802D9360 C7A20068 */  lwc1  $f2, 0x68($sp)
/* 0FDD14 802D9364 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDD18 802D9368 E7BC0014 */  swc1  $f28, 0x14($sp)
/* 0FDD1C 802D936C E7BE0018 */  swc1  $f30, 0x18($sp)
/* 0FDD20 802D9370 AFB7001C */  sw    $s7, 0x1c($sp)
/* 0FDD24 802D9374 AFBE0020 */  sw    $fp, 0x20($sp)
/* 0FDD28 802D9378 0C01C8A4 */  jal   func_80072290
/* 0FDD2C 802D937C E7A20028 */   swc1  $f2, 0x28($sp)
/* 0FDD30 802D9380 080B65A4 */  j     func_802D9690
/* 0FDD34 802D9384 0040A82D */   daddu $s5, $v0, $zero

/* 0FDD38 802D9388 4405A000 */  mfc1  $a1, $f20
/* 0FDD3C 802D938C 4406B000 */  mfc1  $a2, $f22
/* 0FDD40 802D9390 4407C000 */  mfc1  $a3, $f24
/* 0FDD44 802D9394 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDD48 802D9398 0C01C8BC */  jal   func_800722F0
/* 0FDD4C 802D939C AFB40014 */   sw    $s4, 0x14($sp)
/* 0FDD50 802D93A0 080B65A4 */  j     func_802D9690
/* 0FDD54 802D93A4 0040A82D */   daddu $s5, $v0, $zero

/* 0FDD58 802D93A8 4405A000 */  mfc1  $a1, $f20
/* 0FDD5C 802D93AC 4406B000 */  mfc1  $a2, $f22
/* 0FDD60 802D93B0 4407C000 */  mfc1  $a3, $f24
/* 0FDD64 802D93B4 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDD68 802D93B8 E7BC0014 */  swc1  $f28, 0x14($sp)
/* 0FDD6C 802D93BC E7BE0018 */  swc1  $f30, 0x18($sp)
/* 0FDD70 802D93C0 AFB7001C */  sw    $s7, 0x1c($sp)
/* 0FDD74 802D93C4 0C01C8D4 */  jal   func_80072350
/* 0FDD78 802D93C8 AFBE0020 */   sw    $fp, 0x20($sp)
/* 0FDD7C 802D93CC 080B65A4 */  j     func_802D9690
/* 0FDD80 802D93D0 0040A82D */   daddu $s5, $v0, $zero

/* 0FDD84 802D93D4 4405A000 */  mfc1  $a1, $f20
/* 0FDD88 802D93D8 4406B000 */  mfc1  $a2, $f22
/* 0FDD8C 802D93DC 4407C000 */  mfc1  $a3, $f24
/* 0FDD90 802D93E0 8FA30050 */  lw    $v1, 0x50($sp)
/* 0FDD94 802D93E4 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDD98 802D93E8 AFB40014 */  sw    $s4, 0x14($sp)
/* 0FDD9C 802D93EC 0C01C8EC */  jal   func_800723B0
/* 0FDDA0 802D93F0 AFA30018 */   sw    $v1, 0x18($sp)
/* 0FDDA4 802D93F4 080B65A4 */  j     func_802D9690
/* 0FDDA8 802D93F8 0040A82D */   daddu $s5, $v0, $zero

/* 0FDDAC 802D93FC C7A2005C */  lwc1  $f2, 0x5c($sp)
/* 0FDDB0 802D9400 4405A000 */  mfc1  $a1, $f20
/* 0FDDB4 802D9404 4406B000 */  mfc1  $a2, $f22
/* 0FDDB8 802D9408 4407C000 */  mfc1  $a3, $f24
/* 0FDDBC 802D940C E7A2001C */  swc1  $f2, 0x1c($sp)
/* 0FDDC0 802D9410 C7A20060 */  lwc1  $f2, 0x60($sp)
/* 0FDDC4 802D9414 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDDC8 802D9418 E7BC0014 */  swc1  $f28, 0x14($sp)
/* 0FDDCC 802D941C E7BE0018 */  swc1  $f30, 0x18($sp)
/* 0FDDD0 802D9420 0C01C904 */  jal   func_80072410
/* 0FDDD4 802D9424 E7A20020 */   swc1  $f2, 0x20($sp)
/* 0FDDD8 802D9428 080B65A4 */  j     func_802D9690
/* 0FDDDC 802D942C 0040A82D */   daddu $s5, $v0, $zero

/* 0FDDE0 802D9430 4405A000 */  mfc1  $a1, $f20
/* 0FDDE4 802D9434 4406B000 */  mfc1  $a2, $f22
/* 0FDDE8 802D9438 4407C000 */  mfc1  $a3, $f24
/* 0FDDEC 802D943C E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDDF0 802D9440 0C01C91C */  jal   func_80072470
/* 0FDDF4 802D9444 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FDDF8 802D9448 080B65A4 */  j     func_802D9690
/* 0FDDFC 802D944C 0040A82D */   daddu $s5, $v0, $zero

/* 0FDE00 802D9450 4405A000 */  mfc1  $a1, $f20
/* 0FDE04 802D9454 4406B000 */  mfc1  $a2, $f22
/* 0FDE08 802D9458 4407C000 */  mfc1  $a3, $f24
/* 0FDE0C 802D945C C7A2005C */  lwc1  $f2, 0x5c($sp)
/* 0FDE10 802D9460 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDE14 802D9464 E7BC0014 */  swc1  $f28, 0x14($sp)
/* 0FDE18 802D9468 E7BE0018 */  swc1  $f30, 0x18($sp)
/* 0FDE1C 802D946C AFBE0020 */  sw    $fp, 0x20($sp)
/* 0FDE20 802D9470 0C01C94C */  jal   func_80072530
/* 0FDE24 802D9474 E7A2001C */   swc1  $f2, 0x1c($sp)
/* 0FDE28 802D9478 080B65A4 */  j     func_802D9690
/* 0FDE2C 802D947C 0040A82D */   daddu $s5, $v0, $zero

/* 0FDE30 802D9480 4405A000 */  mfc1  $a1, $f20
/* 0FDE34 802D9484 4406B000 */  mfc1  $a2, $f22
/* 0FDE38 802D9488 4407C000 */  mfc1  $a3, $f24
/* 0FDE3C 802D948C E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDE40 802D9490 0C01C964 */  jal   func_80072590
/* 0FDE44 802D9494 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FDE48 802D9498 080B65A4 */  j     func_802D9690
/* 0FDE4C 802D949C 0040A82D */   daddu $s5, $v0, $zero

/* 0FDE50 802D94A0 4405A000 */  mfc1  $a1, $f20
/* 0FDE54 802D94A4 4406B000 */  mfc1  $a2, $f22
/* 0FDE58 802D94A8 4407C000 */  mfc1  $a3, $f24
/* 0FDE5C 802D94AC 0C01C61C */  jal   func_80071870
/* 0FDE60 802D94B0 00000000 */   nop   
/* 0FDE64 802D94B4 080B65A4 */  j     func_802D9690
/* 0FDE68 802D94B8 0040A82D */   daddu $s5, $v0, $zero

/* 0FDE6C 802D94BC 4405A000 */  mfc1  $a1, $f20
/* 0FDE70 802D94C0 4406B000 */  mfc1  $a2, $f22
/* 0FDE74 802D94C4 4407C000 */  mfc1  $a3, $f24
/* 0FDE78 802D94C8 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDE7C 802D94CC 0C01C97C */  jal   func_800725F0
/* 0FDE80 802D94D0 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FDE84 802D94D4 080B65A4 */  j     func_802D9690
/* 0FDE88 802D94D8 0040A82D */   daddu $s5, $v0, $zero

/* 0FDE8C 802D94DC 4405A000 */  mfc1  $a1, $f20
/* 0FDE90 802D94E0 4406B000 */  mfc1  $a2, $f22
/* 0FDE94 802D94E4 4407C000 */  mfc1  $a3, $f24
/* 0FDE98 802D94E8 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDE9C 802D94EC 0C01C994 */  jal   func_80072650
/* 0FDEA0 802D94F0 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FDEA4 802D94F4 080B65A4 */  j     func_802D9690
/* 0FDEA8 802D94F8 0040A82D */   daddu $s5, $v0, $zero

/* 0FDEAC 802D94FC 4405A000 */  mfc1  $a1, $f20
/* 0FDEB0 802D9500 4406B000 */  mfc1  $a2, $f22
/* 0FDEB4 802D9504 4407C000 */  mfc1  $a3, $f24
/* 0FDEB8 802D9508 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDEBC 802D950C 0C01C9AC */  jal   func_800726B0
/* 0FDEC0 802D9510 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FDEC4 802D9514 080B65A4 */  j     func_802D9690
/* 0FDEC8 802D9518 0040A82D */   daddu $s5, $v0, $zero

/* 0FDECC 802D951C 4405A000 */  mfc1  $a1, $f20
/* 0FDED0 802D9520 4406B000 */  mfc1  $a2, $f22
/* 0FDED4 802D9524 4407C000 */  mfc1  $a3, $f24
/* 0FDED8 802D9528 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDEDC 802D952C 0C01C9C4 */  jal   func_80072710
/* 0FDEE0 802D9530 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FDEE4 802D9534 080B65A4 */  j     func_802D9690
/* 0FDEE8 802D9538 0040A82D */   daddu $s5, $v0, $zero

/* 0FDEEC 802D953C 4405A000 */  mfc1  $a1, $f20
/* 0FDEF0 802D9540 4406B000 */  mfc1  $a2, $f22
/* 0FDEF4 802D9544 4407C000 */  mfc1  $a3, $f24
/* 0FDEF8 802D9548 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDEFC 802D954C 0C01C9DC */  jal   func_80072770
/* 0FDF00 802D9550 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FDF04 802D9554 080B65A4 */  j     func_802D9690
/* 0FDF08 802D9558 0040A82D */   daddu $s5, $v0, $zero

/* 0FDF0C 802D955C 4405A000 */  mfc1  $a1, $f20
/* 0FDF10 802D9560 4406B000 */  mfc1  $a2, $f22
/* 0FDF14 802D9564 4407C000 */  mfc1  $a3, $f24
/* 0FDF18 802D9568 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDF1C 802D956C 0C01C9F4 */  jal   func_800727D0
/* 0FDF20 802D9570 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FDF24 802D9574 080B65A4 */  j     func_802D9690
/* 0FDF28 802D9578 0040A82D */   daddu $s5, $v0, $zero

/* 0FDF2C 802D957C 4405A000 */  mfc1  $a1, $f20
/* 0FDF30 802D9580 4406B000 */  mfc1  $a2, $f22
/* 0FDF34 802D9584 4407C000 */  mfc1  $a3, $f24
/* 0FDF38 802D9588 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDF3C 802D958C 0C01CA0C */  jal   func_80072830
/* 0FDF40 802D9590 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FDF44 802D9594 080B65A4 */  j     func_802D9690
/* 0FDF48 802D9598 0040A82D */   daddu $s5, $v0, $zero

/* 0FDF4C 802D959C 4405A000 */  mfc1  $a1, $f20
/* 0FDF50 802D95A0 4406B000 */  mfc1  $a2, $f22
/* 0FDF54 802D95A4 4407C000 */  mfc1  $a3, $f24
/* 0FDF58 802D95A8 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDF5C 802D95AC 0C01CA24 */  jal   func_80072890
/* 0FDF60 802D95B0 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FDF64 802D95B4 080B65A4 */  j     func_802D9690
/* 0FDF68 802D95B8 0040A82D */   daddu $s5, $v0, $zero

/* 0FDF6C 802D95BC 4405A000 */  mfc1  $a1, $f20
/* 0FDF70 802D95C0 4406B000 */  mfc1  $a2, $f22
/* 0FDF74 802D95C4 4407C000 */  mfc1  $a3, $f24
/* 0FDF78 802D95C8 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDF7C 802D95CC 0C01CA3C */  jal   func_800728F0
/* 0FDF80 802D95D0 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FDF84 802D95D4 080B65A4 */  j     func_802D9690
/* 0FDF88 802D95D8 0040A82D */   daddu $s5, $v0, $zero

/* 0FDF8C 802D95DC 4405A000 */  mfc1  $a1, $f20
/* 0FDF90 802D95E0 4406B000 */  mfc1  $a2, $f22
/* 0FDF94 802D95E4 4407C000 */  mfc1  $a3, $f24
/* 0FDF98 802D95E8 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDF9C 802D95EC 0C01CA54 */  jal   func_80072950
/* 0FDFA0 802D95F0 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FDFA4 802D95F4 080B65A4 */  j     func_802D9690
/* 0FDFA8 802D95F8 0040A82D */   daddu $s5, $v0, $zero

/* 0FDFAC 802D95FC 4405A000 */  mfc1  $a1, $f20
/* 0FDFB0 802D9600 4406B000 */  mfc1  $a2, $f22
/* 0FDFB4 802D9604 4407C000 */  mfc1  $a3, $f24
/* 0FDFB8 802D9608 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDFBC 802D960C 0C01CA6C */  jal   func_800729B0
/* 0FDFC0 802D9610 AFB40014 */   sw    $s4, 0x14($sp)
/* 0FDFC4 802D9614 080B65A4 */  j     func_802D9690
/* 0FDFC8 802D9618 0040A82D */   daddu $s5, $v0, $zero

/* 0FDFCC 802D961C 4405A000 */  mfc1  $a1, $f20
/* 0FDFD0 802D9620 4406B000 */  mfc1  $a2, $f22
/* 0FDFD4 802D9624 4407C000 */  mfc1  $a3, $f24
/* 0FDFD8 802D9628 44940000 */  mtc1  $s4, $f0
/* 0FDFDC 802D962C 00000000 */  nop   
/* 0FDFE0 802D9630 46800020 */  cvt.s.w $f0, $f0
/* 0FDFE4 802D9634 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FDFE8 802D9638 0C01CA84 */  jal   func_80072A10
/* 0FDFEC 802D963C E7A00014 */   swc1  $f0, 0x14($sp)
/* 0FDFF0 802D9640 080B65A4 */  j     func_802D9690
/* 0FDFF4 802D9644 0040A82D */   daddu $s5, $v0, $zero

/* 0FDFF8 802D9648 4405A000 */  mfc1  $a1, $f20
/* 0FDFFC 802D964C 4406B000 */  mfc1  $a2, $f22
/* 0FE000 802D9650 4407C000 */  mfc1  $a3, $f24
/* 0FE004 802D9654 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FE008 802D9658 0C01CA9C */  jal   func_80072A70
/* 0FE00C 802D965C AFB40014 */   sw    $s4, 0x14($sp)
/* 0FE010 802D9660 080B65A4 */  j     func_802D9690
/* 0FE014 802D9664 0040A82D */   daddu $s5, $v0, $zero

/* 0FE018 802D9668 4405A000 */  mfc1  $a1, $f20
/* 0FE01C 802D966C 4406B000 */  mfc1  $a2, $f22
/* 0FE020 802D9670 4407C000 */  mfc1  $a3, $f24
/* 0FE024 802D9674 E7BA0010 */  swc1  $f26, 0x10($sp)
/* 0FE028 802D9678 0C01CAB4 */  jal   func_80072AD0
/* 0FE02C 802D967C AFB40014 */   sw    $s4, 0x14($sp)
/* 0FE030 802D9680 080B65A4 */  j     func_802D9690
/* 0FE034 802D9684 0040A82D */   daddu $s5, $v0, $zero

func_802D9688:
.L802D9688:
/* 0FE038 802D9688 080B65A2 */  j     func_802D9688
/* 0FE03C 802D968C 00000000 */   nop   

func_802D9690:
/* 0FE040 802D9690 12A00005 */  beqz  $s5, .L802D96A8
/* 0FE044 802D9694 3C05FE36 */   lui   $a1, 0xfe36
/* 0FE048 802D9698 8FA400C8 */  lw    $a0, 0xc8($sp)
/* 0FE04C 802D969C 34A53C8F */  ori   $a1, $a1, 0x3c8f
/* 0FE050 802D96A0 0C0B2026 */  jal   func_802C8098
/* 0FE054 802D96A4 02A0302D */   daddu $a2, $s5, $zero
.L802D96A8:
/* 0FE058 802D96A8 8FBF0094 */  lw    $ra, 0x94($sp)
/* 0FE05C 802D96AC 8FBE0090 */  lw    $fp, 0x90($sp)
/* 0FE060 802D96B0 8FB7008C */  lw    $s7, 0x8c($sp)
/* 0FE064 802D96B4 8FB60088 */  lw    $s6, 0x88($sp)
/* 0FE068 802D96B8 8FB50084 */  lw    $s5, 0x84($sp)
/* 0FE06C 802D96BC 8FB40080 */  lw    $s4, 0x80($sp)
/* 0FE070 802D96C0 8FB3007C */  lw    $s3, 0x7c($sp)
/* 0FE074 802D96C4 8FB20078 */  lw    $s2, 0x78($sp)
/* 0FE078 802D96C8 8FB10074 */  lw    $s1, 0x74($sp)
/* 0FE07C 802D96CC 8FB00070 */  lw    $s0, 0x70($sp)
/* 0FE080 802D96D0 D7BE00C0 */  ldc1  $f30, 0xc0($sp)
/* 0FE084 802D96D4 D7BC00B8 */  ldc1  $f28, 0xb8($sp)
/* 0FE088 802D96D8 D7BA00B0 */  ldc1  $f26, 0xb0($sp)
/* 0FE08C 802D96DC D7B800A8 */  ldc1  $f24, 0xa8($sp)
/* 0FE090 802D96E0 D7B600A0 */  ldc1  $f22, 0xa0($sp)
/* 0FE094 802D96E4 D7B40098 */  ldc1  $f20, 0x98($sp)
/* 0FE098 802D96E8 24020002 */  addiu $v0, $zero, 2
/* 0FE09C 802D96EC 03E00008 */  jr    $ra
/* 0FE0A0 802D96F0 27BD00C8 */   addiu $sp, $sp, 0xc8

/* 0FE0A4 802D96F4 00000000 */  nop   
/* 0FE0A8 802D96F8 00000000 */  nop   
/* 0FE0AC 802D96FC 00000000 */  nop   