---
title: 磁盘格式及其ID信息
date:  2020-12-09 22:58:16
categories: [硬件设计, 基础知识]
tags: [磁盘, GPT, MBR]
cover: https://gitee.com/mxdon/img/raw/master/2020/image-20201209230345560.png
---
# 磁盘格式及其ID信息

## GPT

| 序号 | 名称 | ID |
| :--: | :-- | :-- |
| 1  | EFI System                     |C12A7328-F81F-11D2-BA4B-00A0C93EC93B|
| 2  | MBR partition scheme           |024DEE41-33E7-11D3-9D69-0008C781F39F|
| 3  | Intel Fast Flash               |D3BFE2DE-3DAF-11DF-BA40-E3A556D89593|
| 4  | BIOS boot                      |21686148-6449-6E6F-744E-656564454649|
| 5  | Microsoft reserved             |E3C9E316-0B5C-4DB8-817D-F92DF00215AE|
| 6  | Microsoft basic data           |EBD0A0A2-B9E5-4433-87C0-68B6B72699C7|
| 7  | Microsoft LDM metadata         |5808C8AA-7E8F-42E0-85D2-E1E90434CFB3|
| 8  | Microsoft LDM data             |AF9B60A0-1431-4F62-BC68-3311714A69AD|
| 9  | Windows recovery environment   |DE94BBA4-06D1-4D40-A16A-BFD50179D6AC|
| 10 | IBM General Parallel Fs        |37AFFC90-EF7D-4E96-91C3-2D7AE055B174|
| 11 | Microsoft Storage Spaces       |E75CAF8F-F680-4CEE-AFA3-B001E56EFC2D|
| 12 | HP-UX data                     |75894C1E-3AEB-11D3-B7C1-7B03A0000000|
| 13 | HP-UX service                  |E2A1E728-32E3-11D6-A682-7B03A0000000|
| 14 | Linux swap                     |0657FD6D-A4AB-43C4-84E5-0933C84B4F4F|
| 15 | Linux filesystem               |0FC63DAF-8483-4772-8E79-3D69D8477DE4|
| 16 | Linux server data              |3B8F8425-20E0-4F3B-907F-1A25A76F98E8|
| 17 | Linux root (x86)               |44479540-F297-41B2-9AF7-D131D5F0458A|
| 18 | Linux root (x86-64)            |4F68BCE3-E8CD-4DB1-96E7-FBCAF984B709|
| 19 | Linux reserved                 |8DA63339-0007-60C0-C436-083AC8230908|
| 20 | Linux home                     |933AC7E1-2EB4-4F13-B844-0E14E2AEF915|
| 21 | Linux RAID                     |A19D880F-05FC-4D3B-A006-743F0F84911E|
| 22 | Linux extended boot            |BC13C2FF-59E6-4262-A352-B275FD6F7172|
| 23 | Linux LVM                      |E6D6D379-F507-44C2-A23C-238F2A3DF928|
| 24 | FreeBSD data                   |516E7CB4-6ECF-11D6-8FF8-00022D09712B|
| 25 | FreeBSD boot                   |83BD6B9D-7F41-11DC-BE0B-001560B84F0F|
| 26 | FreeBSD swap                   |516E7CB5-6ECF-11D6-8FF8-00022D09712B|
| 27 | FreeBSD UFS                    |516E7CB6-6ECF-11D6-8FF8-00022D09712B|
| 28 | FreeBSD ZFS                    |516E7CBA-6ECF-11D6-8FF8-00022D09712B|
| 29 | FreeBSD Vinum                  |516E7CB8-6ECF-11D6-8FF8-00022D09712B|
| 30 | Apple HFS/HFS+                 |48465300-0000-11AA-AA11-00306543ECAC|
| 31 | Apple UFS                      |55465300-0000-11AA-AA11-00306543ECAC|
| 32 | Apple RAID                     |52414944-0000-11AA-AA11-00306543ECAC|
| 33 | Apple RAID offline             |52414944-5F4F-11AA-AA11-00306543ECAC|
| 34 | Apple boot                     |426F6F74-0000-11AA-AA11-00306543ECAC|
| 35 | Apple label                    |4C616265-6C00-11AA-AA11-00306543ECAC|
| 36 | Apple TV recovery              |5265636F-7665-11AA-AA11-00306543ECAC|
| 37 | Apple Core storage             |53746F72-6167-11AA-AA11-00306543ECAC|
| 38 | Solaris boot                   |6A82CB45-1DD2-11B2-99A6-080020736631|
| 39 | Solaris root                   |6A85CF4D-1DD2-11B2-99A6-080020736631|
| 40 | Solaris /usr & Apple ZFS       |6A898CC3-1DD2-11B2-99A6-080020736631|
| 41 | Solaris swap                   |6A87C46F-1DD2-11B2-99A6-080020736631|
| 42 | Solaris backup                 |6A8B642B-1DD2-11B2-99A6-080020736631|
| 43 | Solaris /var                   |6A8EF2E9-1DD2-11B2-99A6-080020736631|
| 44 | Solaris /home                  |6A90BA39-1DD2-11B2-99A6-080020736631|
| 45 | Solaris alternate sector       |6A9283A5-1DD2-11B2-99A6-080020736631|
| 46 | Solaris reserved 1             |6A945A3B-1DD2-11B2-99A6-080020736631|
| 47 | Solaris reserved 2             |6A9630D1-1DD2-11B2-99A6-080020736631|
| 48 | Solaris reserved 3             |6A980767-1DD2-11B2-99A6-080020736631|
| 49 | Solaris reserved 4             |6A96237F-1DD2-11B2-99A6-080020736631|
| 50 | Solaris reserved 5             |6A8D2AC7-1DD2-11B2-99A6-080020736631|
| 51 | NetBSD swap                    |49F48D32-B10E-11DC-B99B-0019D1879648|
| 52 | NetBSD FFS                     |49F48D5A-B10E-11DC-B99B-0019D1879648|
| 53 | NetBSD LFS                     |49F48D82-B10E-11DC-B99B-0019D1879648|
| 54 | NetBSD concatenated            |2DB519C4-B10E-11DC-B99B-0019D1879648|
| 55 | NetBSD encrypted               |2DB519EC-B10E-11DC-B99B-0019D1879648|
| 56 | NetBSD RAID                    |49F48DAA-B10E-11DC-B99B-0019D1879648|
| 57 | ChromeOS kernel                |FE3A2A5D-4F32-41A7-B725-ACCC3285A309|
| 58 | ChromeOS root fs               |3CB8E202-3B7E-47DD-8A3C-7FF2A13CFCEC|
| 59 | ChromeOS reserved              |2E0A753D-9E48-43B0-8337-B15192CB1B5E|
| 60 | MidnightBSD data               |85D5E45A-237C-11E1-B4B3-E89A8F7FC3A7|
| 61 | MidnightBSD boot               |85D5E45E-237C-11E1-B4B3-E89A8F7FC3A7|
| 62 | MidnightBSD swap               |85D5E45B-237C-11E1-B4B3-E89A8F7FC3A7|
| 63 | MidnightBSD UFS                |0394Ef8B-237C-11E1-B4B3-E89A8F7FC3A7|
| 64 | MidnightBSD ZFS                |85D5E45D-237C-11E1-B4B3-E89A8F7FC3A7|
| 65 | MidnightBSD Vinum              |85D5E45C-237C-11E1-B4B3-E89A8F7FC3A7|


## MBR

| 序号 | 名称 | 序号 | 名称 | 序号 | 名称 | 序号 | 名称 |
| :--: | :-- | :--: | :-- | :--: | :-- | :--: | :-- |
|  0  | 空              | 24  | NEC DOS         | 81  | Minix / 旧 Linu | bf  | Solaris        |
|  1  | FAT12           | 27  | 隐藏的 NTFS Win | 82  | Linux 交换 / So | c1  | DRDOS/sec (FAT-|
|  2  | XENIX root      | 39  | Plan 9          | 83  | Linux           | c4  | DRDOS/sec (FAT-|
|  3  | XENIX usr       | 3c  | PartitionMagic  | 84  | OS/2 隐藏的 C:  | c6  | DRDOS/sec (FAT-|
|  4  | FAT16 <32M      | 40  | Venix 80286     | 85  | Linux 扩展      | c7  | Syrinx         |
|  5  | 扩展            | 41  | PPC PReP Boot   | 86  | NTFS 卷集       | da  | 非文件系统数据 |
|  6  | FAT16           | 42  | SFS             | 87  | NTFS 卷集       | db  | CP/M / CTOS / .|
|  7  | HPFS/NTFS/exFAT | 4d  | QNX4.x          | 88  | Linux 纯文本    | de  | Dell 工具      |
|  8  | AIX             | 4e  | QNX4.x 第2部分  | 8e  | Linux LVM       | df  | BootIt         |
|  9  | AIX 可启动      | 4f  | QNX4.x 第3部分  | 93  | Amoeba          | e1  | DOS 访问       |
|  a  | OS/2 启动管理器 | 50  | OnTrack DM      | 94  | Amoeba BBT      | e3  | DOS R/O        |
|  b  | W95 FAT32       | 51  | OnTrack DM6 Aux | 9f  | BSD/OS          | e4  | SpeedStor      |
|  c  | W95 FAT32 (LBA) | 52  | CP/M            | a0  | IBM Thinkpad 休 | eb  | BeOS fs        |
|  e  | W95 FAT16 (LBA) | 53  | OnTrack DM6 Aux | a5  | FreeBSD         | ee  | GPT            |
|  f  | W95 扩展 (LBA)  | 54  | OnTrackDM6      | a6  | OpenBSD         | ef  | EFI (FAT-12/16/|
| 10  | OPUS            | 55  | EZ-Drive        | a7  | NeXTSTEP        | f0  | Linux/PA-RISC  |
| 11  | 隐藏的 FAT12    | 56  | Golden Bow      | a8  | Darwin UFS      | f1  | SpeedStor      |
| 12  | Compaq 诊断     | 5c  | Priam Edisk     | a9  | NetBSD          | f4  | SpeedStor      |
| 14  | 隐藏的 FAT16 <3 | 61  | SpeedStor       | ab  | Darwin 启动     | f2  | DOS 次要       |
| 16  | 隐藏的 FAT16    | 63  | GNU HURD or Sys | af  | HFS / HFS+      | fb  | VMware VMFS    |
| 17  | 隐藏的 HPFS/NTF | 64  | Novell Netware  | b7  | BSDI fs         | fc  | VMware VMKCORE |
| 18  | AST 智能睡眠    | 65  | Novell Netware  | b8  | BSDI swap       | fd  | Linux raid 自动|
| 1b  | 隐藏的 W95 FAT3 | 70  | DiskSecure 多启 | bb  | Boot Wizard 隐  | fe  | LANstep        |
| 1c  | 隐藏的 W95 FAT3 | 75  | PC/IX           | be  | Solaris 启动    | ff  | BBT            |
| 1e  | 隐藏的 W95 FAT1 | 80  | 旧 Minix        |     |                 |     |                |

## 最后，点个关注不迷路

> 公众号：[孟游先生的旅游笔记](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/8a089ae12bfb4ca9a9e5d9ac82f58d43~tplv-k3u1fbpfcp-zoom-1.image)
