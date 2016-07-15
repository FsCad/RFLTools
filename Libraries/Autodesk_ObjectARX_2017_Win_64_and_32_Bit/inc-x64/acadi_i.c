//////////////////////////////////////////////////////////////////////////////
//
//  Copyright 2016 Autodesk, Inc.  All rights reserved.
//
//  Use of this software is subject to the terms of the Autodesk license 
//  agreement provided at the time of installation or download, or which 
//  otherwise accompanies this software in either electronic or hard copy form.   
//
//////////////////////////////////////////////////////////////////////////////



/* this ALWAYS GENERATED file contains the IIDs and CLSIDs */

/* link this file in with the server and any clients */


 /* File created by MIDL compiler version 8.00.0613 */
/* at Mon Jan 18 19:14:07 2038
 */
/* Compiler settings for idlsource\acad.idl:
    Oicf, W1, Zp8, env=Win64 (32b run), target_arch=AMD64 8.00.0613 
    protocol : dce , ms_ext, c_ext, robust
    error checks: allocation ref bounds_check enum stub_data 
    VC __declspec() decoration level: 
         __declspec(uuid()), __declspec(selectany), __declspec(novtable)
         DECLSPEC_UUID(), MIDL_INTERFACE()
*/
/* @@MIDL_FILE_HEADING(  ) */

#pragma warning( disable: 4049 )  /* more than 64k source lines */


#ifdef __cplusplus
extern "C"{
#endif 


#include <rpc.h>
#include <rpcndr.h>

#ifdef _MIDL_USE_GUIDDEF_

#ifndef INITGUID
#define INITGUID
#include <guiddef.h>
#undef INITGUID
#else
#include <guiddef.h>
#endif

#define MIDL_DEFINE_GUID(type,name,l,w1,w2,b1,b2,b3,b4,b5,b6,b7,b8) \
        DEFINE_GUID(name,l,w1,w2,b1,b2,b3,b4,b5,b6,b7,b8)

#else // !_MIDL_USE_GUIDDEF_

#ifndef __IID_DEFINED__
#define __IID_DEFINED__

typedef struct _IID
{
    unsigned long x;
    unsigned short s1;
    unsigned short s2;
    unsigned char  c[8];
} IID;

#endif // __IID_DEFINED__

#ifndef CLSID_DEFINED
#define CLSID_DEFINED
typedef IID CLSID;
#endif // CLSID_DEFINED

#define MIDL_DEFINE_GUID(type,name,l,w1,w2,b1,b2,b3,b4,b5,b6,b7,b8) \
        const type name = {l,w1,w2,{b1,b2,b3,b4,b5,b6,b7,b8}}

#endif !_MIDL_USE_GUIDDEF_

MIDL_DEFINE_GUID(IID, LIBID_AutoCAD,0x5B3245BE,0x661C,0x4324,0xBB,0x55,0x3A,0xD9,0x4E,0xBB,0xFD,0xD7);


MIDL_DEFINE_GUID(IID, IID_IAcadObject,0x701F68D5,0xCA96,0x4964,0x89,0x7A,0x17,0xA3,0xCF,0xCC,0xEE,0xDE);


MIDL_DEFINE_GUID(IID, IID_IAcadDictionary,0xA71CED3B,0xB6FB,0x4946,0xB7,0x16,0xA1,0xA2,0xC7,0xE7,0x53,0xAE);


MIDL_DEFINE_GUID(IID, IID_IAcadEntity,0x7726A04E,0xC83E,0x4E3E,0x8D,0xA5,0x81,0x44,0xAD,0x1E,0x96,0x47);


MIDL_DEFINE_GUID(IID, IID_IAcadBlock,0xF894BBF4,0x64B0,0x444E,0xB1,0x7F,0xEE,0x8A,0xEA,0xCB,0x6A,0x7B);


MIDL_DEFINE_GUID(IID, IID_IAcadDatabase,0x7D8F3D3B,0x5265,0x44AD,0xA3,0x79,0x63,0x0B,0xD2,0x87,0xD3,0xF6);


MIDL_DEFINE_GUID(IID, IID_IAcadSectionTypeSettings,0xBB6ECC4B,0x3C35,0x4988,0x81,0x63,0x03,0x9F,0x79,0x58,0xF0,0xA2);


MIDL_DEFINE_GUID(IID, IID_IAcadSectionTypeSettings2,0x71B4458E,0xC4BB,0x481D,0x99,0xAC,0x97,0x42,0x35,0xE9,0x68,0x3F);


MIDL_DEFINE_GUID(IID, IID_IAcadHyperlink,0x5ED3953D,0xEFEF,0x468F,0x94,0xB4,0xC1,0x86,0x94,0x30,0x65,0xC7);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadHyperlink,0x82547C8C,0x44A8,0x42D7,0xAD,0x98,0x07,0x81,0x66,0xC5,0x73,0xA5);


MIDL_DEFINE_GUID(IID, IID_IAcadDynamicBlockReferenceProperty,0xFEBC2207,0x9463,0x4CD9,0xB6,0xF4,0x8F,0xDE,0x6B,0x98,0x0F,0x68);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadDynamicBlockReferenceProperty,0xFB58C0F7,0x5A5C,0x453B,0x86,0x02,0x53,0xE7,0x85,0xEF,0x0F,0x14);


MIDL_DEFINE_GUID(IID, IID_IAcadAcCmColor,0xB98FC4BA,0x8681,0x4E0F,0xA9,0x90,0x15,0x37,0x6F,0x9E,0x83,0x74);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadAcCmColor,0x8489ED0D,0x5A6D,0x4C59,0xB1,0x73,0x2F,0x98,0x55,0xDE,0x49,0x6C);


MIDL_DEFINE_GUID(IID, IID_IAcadObjectEvents,0x64759B9C,0x96D8,0x4BB9,0xAA,0xF9,0xB7,0x0D,0xA3,0x23,0xDC,0xA4);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadObject,0xCC65C4AF,0x6B21,0x4F18,0x9E,0x97,0x11,0xFD,0xE9,0x63,0xC5,0x5E);


MIDL_DEFINE_GUID(IID, IID_IAcadXRecord,0x33F0261F,0xF878,0x4C5B,0x85,0xBC,0xF8,0x61,0x96,0x0A,0xB7,0x2B);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadXRecord,0xABBB188C,0x0FAD,0x40C3,0x87,0xFC,0x1E,0x2F,0xBF,0x9D,0x44,0x5C);


MIDL_DEFINE_GUID(IID, IID_IAcadSortentsTable,0x8216FDF1,0x3773,0x4988,0x96,0xF8,0x0F,0xA8,0x33,0x4C,0xF9,0xCC);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadSortentsTable,0x2A16F892,0x4AD1,0x4F21,0x99,0x17,0x62,0x4A,0x8D,0x06,0xA6,0x51);


MIDL_DEFINE_GUID(IID, IID_IAcadDimStyle,0x8F914C29,0xD8BF,0x496A,0x82,0x0F,0xAE,0xCD,0xFF,0xF5,0x11,0x57);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadDimStyle,0x19757890,0xE59D,0x4DC4,0x99,0x19,0x6D,0xE6,0x1F,0x98,0xD2,0x74);


MIDL_DEFINE_GUID(IID, IID_IAcadLayer,0x6EA285F5,0x5A1E,0x4E7B,0x98,0x57,0x63,0x9E,0x40,0x86,0xAE,0x19);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadLayer,0x063B89E8,0x3728,0x4C7A,0xA6,0xB5,0xC2,0x15,0x0C,0xA6,0xAE,0xB8);


MIDL_DEFINE_GUID(IID, IID_IAcadLineType,0x401FAF8B,0x5CF4,0x4EB4,0x9C,0xE6,0xD6,0x92,0x9C,0xF6,0x05,0x53);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadLineType,0xD0282B8F,0x2FF8,0x41E9,0xB9,0x19,0xE4,0x93,0xD9,0x60,0xDE,0x4C);


MIDL_DEFINE_GUID(IID, IID_IAcadMaterial,0x82CD8077,0x8E62,0x4AEE,0x85,0xDB,0xC6,0xBE,0xAC,0xFB,0xD7,0x41);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadMaterial,0xE8088DA8,0xB0EF,0x437E,0xBF,0xCF,0xE3,0x8A,0x73,0xE3,0xFC,0x04);


MIDL_DEFINE_GUID(IID, IID_IAcadRegisteredApplication,0x06050E6D,0xA9B2,0x4C5A,0x90,0x9A,0xFA,0x40,0xCC,0x57,0xAB,0x61);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadRegisteredApplication,0xB911B0D4,0x5599,0x4498,0xA6,0xC3,0x65,0x4A,0x36,0x1D,0x98,0x4E);


MIDL_DEFINE_GUID(IID, IID_IAcadTextStyle,0x2F744465,0xFE75,0x48D0,0xAF,0x68,0xC8,0xC6,0x33,0x61,0x42,0x83);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadTextStyle,0x5E5580AD,0x5750,0x4DB1,0x85,0xAA,0xD1,0x5B,0xC2,0xA4,0xF6,0xE8);


MIDL_DEFINE_GUID(IID, IID_IAcadUCS,0x235F0898,0x9076,0x48C8,0x8E,0xEE,0xA3,0xDC,0xB7,0x53,0x18,0x9E);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadUCS,0x37C0E6FF,0xF35A,0x4498,0xB5,0x3A,0xF6,0xEF,0x19,0x03,0x64,0xCF);


MIDL_DEFINE_GUID(IID, IID_IAcadView,0x8C2095AE,0xD12A,0x4AF0,0x95,0x8E,0x82,0xD7,0x65,0xFE,0x5D,0x6F);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadView,0x3AA0D898,0xAF91,0x4BFD,0x87,0x1B,0x68,0x84,0xF7,0x41,0xF7,0x4A);


MIDL_DEFINE_GUID(IID, IID_IAcadViewport,0x22E43AA3,0x270F,0x4F6C,0xAC,0xA4,0x1A,0x88,0x76,0x9B,0x04,0xF5);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadViewport,0x4360A8E5,0xFE2C,0x470C,0x86,0xAC,0x69,0xDF,0x9E,0x78,0xD9,0xCD);


MIDL_DEFINE_GUID(IID, IID_IAcadGroup,0x05A2CC54,0x2ABD,0x4722,0xBB,0x71,0x1C,0xBE,0xC9,0x47,0xDA,0xFC);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadGroup,0x3A028ECB,0xFD98,0x466D,0x9D,0xD1,0x7B,0xE3,0xAB,0xFD,0x21,0x9B);


MIDL_DEFINE_GUID(IID, IID_IAcadPlotConfiguration,0x50DB2D91,0xC05B,0x40DB,0x85,0x3B,0xCD,0x4E,0xE5,0xB3,0xCB,0x96);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadPlotConfiguration,0xE8D2BE0B,0xFC02,0x44E6,0xA9,0xCE,0x6C,0x8F,0x3F,0x9A,0xC2,0x8E);


MIDL_DEFINE_GUID(IID, IID_IAcadLayout,0xDFE6FFB2,0x5BEE,0x4C18,0xA6,0x51,0x12,0xF9,0x41,0x48,0xE4,0xC9);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadLayout,0xD9E05C36,0xB6DF,0x497E,0x8B,0x17,0xA7,0xE4,0x64,0xD5,0xAE,0x38);


MIDL_DEFINE_GUID(IID, IID_IAcadIdPair,0x6C8C749A,0xF80C,0x4FEE,0xBF,0x0D,0xC0,0xF3,0x54,0xF2,0x4D,0x34);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadIdPair,0xCCD8F5AC,0x6BE4,0x4339,0x8F,0xA4,0x96,0x92,0x5A,0x91,0x17,0x53);


MIDL_DEFINE_GUID(IID, IID_IAcadTableStyle,0xE81E0641,0x8C00,0x45CC,0x89,0x86,0x80,0xF0,0x9C,0x4C,0x15,0xE7);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadTableStyle,0x52714180,0x45EE,0x43AC,0x80,0xB0,0xD6,0x9B,0x79,0x40,0xC5,0x0D);


MIDL_DEFINE_GUID(IID, IID_IAcadSectionSettings,0xB7BCDFC6,0x7775,0x4404,0xB4,0x5A,0xAE,0xB9,0x67,0x49,0xDB,0x9D);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadSectionSettings,0x6951AFB4,0x324F,0x4218,0x82,0xEB,0xA6,0x47,0x6E,0x15,0x4B,0x02);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadSectionTypeSettings,0xBA697283,0x3CDA,0x4918,0x9A,0xEB,0xE0,0xE1,0x5F,0xC3,0x42,0x77);


MIDL_DEFINE_GUID(IID, IID_IAcadMLeaderStyle,0xCFBC9C0A,0x9C90,0x428D,0x9E,0xB6,0x9F,0x6E,0x76,0xF6,0xC0,0x86);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadMLeaderStyle,0xE1F219D1,0x1558,0x4EAB,0xB6,0xEF,0x5B,0x9A,0x2A,0x57,0xFC,0xA7);


MIDL_DEFINE_GUID(IID, IID_IAcadHyperlinks,0xF13C0B1D,0x6F1A,0x4D21,0x89,0x39,0x44,0x7C,0xCE,0x7F,0x4E,0xFF);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadHyperlinks,0x45C632D0,0xF5DD,0x4C7C,0x91,0x82,0x0B,0xDE,0x8A,0x77,0x11,0x9B);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadDictionary,0xC5F3036D,0xACD5,0x40A6,0xB8,0x22,0x5B,0xED,0xA2,0xC8,0x06,0x83);


MIDL_DEFINE_GUID(IID, IID_IAcadLayers,0x276D0DB1,0x26BA,0x4E72,0x93,0xC6,0xE1,0x5E,0xAE,0xBA,0xAD,0xED);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadLayers,0x273D815C,0x6C08,0x4AFA,0x90,0x4D,0xA1,0x24,0xC6,0x5D,0x85,0x83);


MIDL_DEFINE_GUID(IID, IID_IAcadDimStyles,0xCC87A11F,0x7DC4,0x4869,0xA7,0xE7,0x28,0xCE,0x72,0xE3,0xA8,0xB6);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadDimStyles,0xC89600D1,0x9CAB,0x4333,0x96,0x98,0x55,0x86,0x0F,0x7E,0xB4,0xFB);


MIDL_DEFINE_GUID(IID, IID_IAcadDictionaries,0x96DF2067,0x396E,0x429A,0x9D,0x4E,0x44,0x4D,0xE9,0x77,0xCE,0x8D);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadDictionaries,0xAF26D17C,0xC40A,0x4DBE,0xB7,0x42,0xF0,0x29,0xDC,0xC4,0xF3,0xC0);


MIDL_DEFINE_GUID(IID, IID_IAcadLineTypes,0x77926692,0x1E0C,0x4D84,0x94,0xB9,0x56,0x6D,0x36,0x5C,0x9B,0x15);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadLineTypes,0x875F8998,0xEC9A,0x4D25,0xAD,0xC2,0x5D,0x31,0x78,0xD8,0xEA,0x3C);


MIDL_DEFINE_GUID(IID, IID_IAcadMaterials,0x5DABEB7C,0xDE8C,0x4499,0x9B,0xC1,0x97,0x6F,0xF0,0x8F,0x19,0xAC);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadMaterials,0x8F96AC9F,0x4CCC,0x4A0A,0x8B,0xEA,0x70,0x41,0x2E,0x23,0x16,0x0C);


MIDL_DEFINE_GUID(IID, IID_IAcadTextStyles,0x23DAAF27,0xADF7,0x4ADE,0x8E,0x59,0x41,0x36,0xEB,0xDB,0xFC,0x00);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadTextStyles,0x33958D6A,0x4322,0x4590,0x92,0x27,0xC0,0x32,0x3C,0x43,0x9B,0x86);


MIDL_DEFINE_GUID(IID, IID_IAcadUCSs,0x166BE29B,0xBC14,0x49F0,0x8B,0x3D,0x07,0xFF,0x2B,0xAF,0xAD,0x0E);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadUCSs,0x0D11ACB2,0x2120,0x4B39,0xAA,0xA4,0xBC,0x7A,0x9B,0x2D,0xA4,0x29);


MIDL_DEFINE_GUID(IID, IID_IAcadRegisteredApplications,0x0DF536E7,0x177E,0x4A4A,0x9B,0xFF,0xFE,0xD2,0x12,0x41,0xDE,0x8A);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadRegisteredApplications,0x0796C07B,0x889A,0x4D0C,0xBC,0x16,0x93,0x9A,0xD0,0xB6,0x89,0xF4);


MIDL_DEFINE_GUID(IID, IID_IAcadViews,0x64376B3F,0x6C86,0x4CA3,0xAF,0x69,0x48,0xEA,0x2E,0xAE,0x3F,0xB1);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadViews,0xB32A697C,0x2268,0x4828,0xB7,0x57,0x50,0x7C,0x78,0x3C,0xFC,0x70);


MIDL_DEFINE_GUID(IID, IID_IAcadViewports,0xD486D6C3,0xA10D,0x4ED0,0x91,0x90,0xD0,0x38,0x93,0x57,0x35,0x4E);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadViewports,0x0FC62543,0xA5F1,0x4C19,0x96,0x82,0xDE,0x84,0x08,0xA4,0xB2,0x12);


MIDL_DEFINE_GUID(IID, IID_IAcadGroups,0xA6476F94,0x1673,0x4E4F,0xB0,0x46,0x38,0x33,0x20,0x36,0xBB,0x84);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadGroups,0xA3808A1E,0x1CAC,0x4C14,0xA4,0x43,0x99,0x8F,0x26,0x66,0x9F,0xF1);


MIDL_DEFINE_GUID(IID, IID_IAcadBlocks,0x5BC550E4,0xBA3C,0x4B1D,0xAF,0xC6,0xFB,0x86,0x9F,0x2D,0x9E,0x49);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadBlocks,0x8A8FD330,0xD31D,0x4639,0xBD,0x3B,0x56,0x91,0x63,0xB2,0xEB,0xE9);


MIDL_DEFINE_GUID(IID, IID_IAcadLayouts,0x86E36A88,0xD3F5,0x4595,0xA4,0x59,0x7E,0x99,0x12,0x54,0x37,0xA0);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadLayouts,0xD8842A05,0xF84A,0x404B,0x9A,0xDF,0xC9,0xD3,0x80,0xF0,0x26,0x2D);


MIDL_DEFINE_GUID(IID, IID_IAcadPlotConfigurations,0x0465A6BB,0x26BD,0x4D21,0xA9,0x48,0xA2,0xFA,0xCD,0x9D,0x83,0xA0);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadPlotConfigurations,0x3DB4B2BF,0xF58A,0x407D,0x86,0x26,0x4C,0xBD,0xE8,0x6C,0x1F,0xB0);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadEntity,0x9B768196,0x44AA,0x4728,0x94,0x8E,0x22,0x06,0x1D,0x60,0x50,0x16);


MIDL_DEFINE_GUID(IID, IID_IAcadShadowDisplay,0x7C2F249E,0x794E,0x4F59,0xB9,0xA9,0xEC,0xCB,0x6F,0xD6,0x7F,0xCC);


MIDL_DEFINE_GUID(IID, IID_IAcadRasterImage,0x19958741,0x9A6F,0x4703,0xA3,0x09,0x39,0x80,0x57,0x3E,0xB9,0x59);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadRasterImage,0xC8AC1000,0xD574,0x4A8B,0xAB,0x3C,0xF3,0x45,0xBA,0xEF,0x36,0x83);


MIDL_DEFINE_GUID(IID, IID_IAcad3DFace,0x0A6CE6AA,0x2A8C,0x4040,0xAA,0x5B,0x9B,0xE3,0xE6,0x8A,0x59,0x45);


MIDL_DEFINE_GUID(CLSID, CLSID_Acad3DFace,0x463D5542,0xC77E,0x4F8C,0x85,0xFF,0xD7,0x49,0x3A,0x43,0xBD,0x3F);


MIDL_DEFINE_GUID(IID, IID_IAcad3DPolyline,0x46DE8975,0x5B1F,0x4E2A,0x83,0xFA,0x0B,0xAB,0xD8,0xFB,0xE8,0x11);


MIDL_DEFINE_GUID(CLSID, CLSID_Acad3DPolyline,0x3040CCB9,0xE25B,0x4087,0xB3,0x6D,0xD2,0xF4,0x09,0xB7,0x33,0x8F);


MIDL_DEFINE_GUID(IID, IID_IAcadRegion,0x27E929CE,0xD7F3,0x4BE3,0xBD,0x00,0xD8,0xB4,0xB6,0x56,0xC2,0xB4);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadRegion,0x806B9CA4,0x9DB9,0x445A,0x83,0xD2,0x87,0xF7,0xBB,0x1D,0x00,0x72);


MIDL_DEFINE_GUID(IID, IID_IAcad3DSolid,0x41AE765A,0xA270,0x4D0F,0x9E,0x4B,0xC9,0xDC,0x61,0xA5,0x34,0x1F);


MIDL_DEFINE_GUID(CLSID, CLSID_Acad3DSolid,0x07621A84,0x9457,0x415D,0xBF,0xD7,0xE9,0x3C,0x90,0x96,0x6F,0x97);


MIDL_DEFINE_GUID(IID, IID_IAcadArc,0x923F64D9,0x7F9A,0x49F8,0xAC,0xCE,0x23,0x3C,0xB4,0xDA,0xA4,0x7D);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadArc,0x585BFF19,0x0001,0x43E6,0xA7,0x37,0x43,0x15,0xDC,0x7D,0x38,0xDC);


MIDL_DEFINE_GUID(IID, IID_IAcadAttribute,0xE666672A,0xF737,0x4D88,0xAB,0x6F,0x23,0x28,0xC8,0xB5,0xD6,0x9A);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadAttribute,0xA3238286,0x3FBE,0x47D3,0x99,0xAB,0x6B,0xEF,0xF7,0x1F,0xB6,0xDD);


MIDL_DEFINE_GUID(IID, IID_IAcadAttributeReference,0xA82ACB8B,0xA1E0,0x4A2A,0xBB,0x26,0xDB,0xB2,0x13,0x61,0x12,0xEF);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadAttributeReference,0x8D352F9D,0x9032,0x4D35,0xAE,0x8B,0x1A,0x2D,0xC4,0xA8,0xBF,0xDA);


MIDL_DEFINE_GUID(IID, IID_IAcadBlockReference,0x8A6EBB33,0x3519,0x489F,0xAA,0x4A,0x55,0x31,0x20,0x4F,0xFA,0xD7);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadBlockReference,0x90B39404,0xB229,0x4FC9,0xA4,0xB1,0x8E,0xE6,0xBD,0x0C,0x47,0x29);


MIDL_DEFINE_GUID(IID, IID_IAcadCircle,0x0698888C,0x3A25,0x4933,0xAC,0x73,0xE3,0x94,0xA5,0x50,0x27,0x9A);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadCircle,0x92025176,0x077A,0x4E9D,0xA2,0x26,0xD4,0x7E,0x3C,0x7B,0xE3,0xEC);


MIDL_DEFINE_GUID(IID, IID_IAcadEllipse,0x505E1E54,0x2BE5,0x4EFC,0x9F,0x38,0x40,0xAF,0x81,0x50,0xA7,0x0C);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadEllipse,0xA5BF4DA8,0x0AE4,0x47FB,0x86,0xFD,0xD2,0x12,0xC7,0xBE,0x23,0x89);


MIDL_DEFINE_GUID(IID, IID_IAcadHatch,0x87CDEC00,0x6F05,0x47AB,0x99,0x62,0xC3,0x4B,0x15,0x57,0x1A,0x7E);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadHatch,0x74C21669,0x1C61,0x45E7,0x90,0x1B,0x3B,0xB4,0xA0,0xB0,0x93,0x70);


MIDL_DEFINE_GUID(IID, IID_IAcadLeader,0x54C965DD,0x56EA,0x418F,0x9B,0x10,0xDD,0x9C,0xDF,0x43,0xFC,0xDB);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadLeader,0xDBB18BED,0x79B7,0x4430,0xAC,0x0B,0x1E,0x83,0x0F,0x36,0x57,0x63);


MIDL_DEFINE_GUID(IID, IID_IAcadSubEntity,0x80EE347D,0xF0D4,0x4F1E,0x96,0xA5,0xD2,0x90,0xAA,0xED,0xAD,0xBF);


MIDL_DEFINE_GUID(IID, IID_IAcadMLeaderLeader,0x1ECC1CF4,0xD5DC,0x4F6F,0x97,0xBA,0xD0,0x44,0x9E,0x48,0x00,0x2F);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadMLeaderLeader,0x53A02CFF,0x6900,0x4D72,0x9F,0xF5,0xB9,0xD6,0xBF,0x66,0xAA,0xCC);


MIDL_DEFINE_GUID(IID, IID_IAcadMLeader,0x1FA2EBD8,0xB3D0,0x4CE6,0x87,0xF1,0x94,0xD5,0x1C,0xA9,0xFF,0x5E);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadMLeader,0xBB1F3896,0xD460,0x401A,0x80,0x74,0x07,0x48,0xBE,0xA7,0x42,0x75);


MIDL_DEFINE_GUID(IID, IID_IAcadLWPolyline,0x2916D4BE,0xB6CF,0x479E,0xB7,0x95,0x0C,0xD3,0xAA,0xC9,0x3D,0x51);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadLWPolyline,0x3E475628,0xC0C3,0x4BA5,0x94,0x69,0x64,0xB3,0x80,0x21,0x21,0xB0);


MIDL_DEFINE_GUID(IID, IID_IAcadLine,0x57148E79,0xE703,0x4C07,0x99,0x7F,0xA8,0x7E,0xAD,0xCC,0x03,0xEB);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadLine,0x19024DF1,0x65F2,0x41D2,0x9F,0xC2,0xC6,0xD1,0x6B,0x51,0xFC,0xB6);


MIDL_DEFINE_GUID(IID, IID_IAcadMText,0xA5D8740C,0xB207,0x4251,0xBC,0xA6,0x7E,0x41,0xA7,0xAB,0xB3,0x3D);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadMText,0x62633E55,0x0DCC,0x48D7,0x84,0x38,0x3F,0xA1,0x31,0xCA,0xDF,0x6C);


MIDL_DEFINE_GUID(IID, IID_IAcadPoint,0x94C851C5,0x82E4,0x40DF,0xB7,0xDB,0xD0,0x00,0xD0,0xAB,0x90,0xF0);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadPoint,0xEEF55288,0xC754,0x491C,0xB4,0xE1,0xD5,0x33,0x93,0xBF,0x88,0xAD);


MIDL_DEFINE_GUID(IID, IID_IAcadPolyline,0xD42053BC,0x2377,0x4E6A,0x8D,0xE2,0x61,0xEF,0x77,0xF5,0x12,0xB7);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadPolyline,0x46AEE2CC,0xA92F,0x4BA9,0xB6,0xB3,0x13,0x40,0x3D,0x79,0xD6,0xD3);


MIDL_DEFINE_GUID(IID, IID_IAcadPolygonMesh,0xFB167EC0,0xA75B,0x46EB,0x87,0x5B,0x12,0x5F,0x75,0x7F,0xFE,0xA5);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadPolygonMesh,0x73ED65E4,0xEF95,0x488E,0x9F,0x14,0xC0,0x1D,0x69,0x12,0x5A,0x48);


MIDL_DEFINE_GUID(IID, IID_IAcadRay,0xADC3F03F,0x8CA5,0x43EA,0xA1,0x25,0xA7,0x58,0x92,0x3D,0xE9,0x2A);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadRay,0x1E8D9695,0xE3C1,0x4047,0x88,0x47,0x0D,0x01,0xB0,0xA4,0x35,0x64);


MIDL_DEFINE_GUID(IID, IID_IAcadShape,0x97F318AA,0xC86D,0x476C,0xAC,0x0C,0x19,0x04,0xF6,0x87,0x6C,0x32);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadShape,0xB8C7D559,0x9516,0x4157,0xB0,0x63,0x61,0x3B,0xFA,0xF8,0x3B,0xB8);


MIDL_DEFINE_GUID(IID, IID_IAcadSolid,0x064CB0D1,0x97F5,0x4639,0x96,0x79,0x29,0x53,0x5F,0x30,0xC5,0x57);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadSolid,0x8CDF4C9E,0xF1C5,0x4264,0xB3,0xE7,0x6A,0xA4,0x4B,0x5B,0xB8,0x9F);


MIDL_DEFINE_GUID(IID, IID_IAcadSpline,0x049327DE,0x03F1,0x4F09,0x88,0x7E,0x68,0xAE,0xD5,0x3A,0x83,0x4E);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadSpline,0x409885E6,0xF896,0x4EFD,0xBC,0xC4,0x16,0x09,0x31,0x32,0x5E,0x5C);


MIDL_DEFINE_GUID(IID, IID_IAcadText,0xBDF522E4,0xFB60,0x423D,0x82,0xDE,0xEB,0x42,0x2E,0x01,0x92,0xDC);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadText,0xAFD81966,0x5CBF,0x4756,0x90,0x61,0xEB,0x50,0x69,0xC5,0x4D,0xBC);


MIDL_DEFINE_GUID(IID, IID_IAcadTolerance,0x5D10173F,0x7DBD,0x4633,0x90,0x94,0xF5,0x93,0xB2,0x73,0x21,0x8D);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadTolerance,0xFBE13464,0x124F,0x4A81,0x8B,0x5C,0x04,0xDE,0x69,0xEA,0xC0,0x6F);


MIDL_DEFINE_GUID(IID, IID_IAcadTrace,0xDC97E062,0xD7A8,0x47EC,0x88,0xB1,0x3B,0x33,0xA8,0xD4,0x69,0x2B);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadTrace,0x2111BF4D,0xB691,0x4E68,0xA0,0x21,0x4B,0x17,0xCF,0x32,0xAB,0x8F);


MIDL_DEFINE_GUID(IID, IID_IAcadXline,0xD4981074,0x77B0,0x4F38,0xB4,0x6E,0x60,0x68,0xF2,0xDF,0xB1,0xFA);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadXline,0x1A368D01,0x0A8E,0x496D,0x92,0x92,0xE3,0x02,0xD4,0xB5,0x30,0x63);


MIDL_DEFINE_GUID(IID, IID_IAcadPViewport,0x95703222,0x0ED3,0x4831,0x89,0x1C,0xE5,0xE0,0x34,0xAE,0xBE,0xB2);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadPViewport,0x894A26C0,0x7E80,0x4336,0x87,0xD4,0xFE,0x2C,0x75,0x8A,0xD8,0x88);


MIDL_DEFINE_GUID(IID, IID_IAcadMInsertBlock,0xC22F19FC,0xC649,0x4BE5,0xAC,0x84,0xF5,0x1E,0x81,0xD7,0xE6,0x36);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadMInsertBlock,0x0DA9547B,0x9E13,0x4549,0x8B,0x01,0x78,0xC3,0x14,0xAC,0xCE,0x69);


MIDL_DEFINE_GUID(IID, IID_IAcadPolyfaceMesh,0x4328430B,0x0AA0,0x4949,0x87,0x70,0x22,0x64,0x44,0x8C,0xBE,0x72);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadPolyfaceMesh,0x9BB89379,0xE21C,0x49C4,0x99,0x7C,0x70,0x93,0xC0,0xFD,0x6C,0x28);


MIDL_DEFINE_GUID(IID, IID_IAcadMLine,0x36797313,0xD2D7,0x4B32,0xA1,0x26,0x29,0x10,0xB0,0xE1,0x6E,0x99);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadMLine,0x208EA3A0,0xEA41,0x4378,0xA4,0x34,0x29,0xCE,0x36,0x73,0x2B,0xC1);


MIDL_DEFINE_GUID(IID, IID_IAcadExternalReference,0xD99013EF,0xC216,0x4B39,0x9D,0x8D,0xF3,0xA8,0x27,0xB8,0x49,0x9B);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadExternalReference,0xBFBFAA19,0x212A,0x47EF,0xBC,0x01,0xE7,0x30,0xA6,0xE0,0x5B,0xB8);


MIDL_DEFINE_GUID(IID, IID_IAcadTable,0x651C43ED,0x3B0C,0x4A54,0xA0,0x33,0xFA,0xBE,0x99,0xF7,0x09,0xBF);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadTable,0x5D0F5C31,0xDF55,0x446B,0xAA,0xA2,0x2A,0x56,0x32,0x35,0xBA,0x44);


MIDL_DEFINE_GUID(IID, IID_IAcadOle,0x249F558F,0x477A,0x4C32,0x9B,0x2C,0x93,0xCD,0xFC,0xFD,0xDE,0xE1);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadOle,0xC6C73F45,0x8A5A,0x4A1F,0x9F,0xFE,0x31,0xDE,0xD6,0xA8,0x51,0x23);


MIDL_DEFINE_GUID(IID, IID_IAcadHelix,0x84AC53FF,0xE874,0x43E5,0xB1,0xFD,0x1C,0xF5,0x70,0xE7,0x4A,0xBA);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadHelix,0xDA09C4EE,0x95DE,0x4382,0x95,0xCC,0x70,0x68,0xEA,0x23,0x31,0x82);


MIDL_DEFINE_GUID(IID, IID_IAcadSurface,0xF7586B4E,0x2C0A,0x43E3,0xB9,0x86,0xAF,0xCF,0x22,0x13,0xCA,0xE4);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadSurface,0x1E24C48F,0x197D,0x42F6,0xA8,0x65,0x3D,0x95,0xF0,0xAB,0x2D,0x27);


MIDL_DEFINE_GUID(IID, IID_IAcadPlaneSurface,0xF8193567,0xE58C,0x4A77,0xAC,0xB4,0x40,0x43,0x2E,0xE0,0xC8,0x3D);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadPlaneSurface,0xEEC9E51D,0xA609,0x4D31,0x80,0xA1,0x51,0x9D,0xD3,0x63,0x94,0xFA);


MIDL_DEFINE_GUID(IID, IID_IAcadExtrudedSurface,0xE534271A,0x1C36,0x4146,0xB0,0x4F,0x6F,0x4F,0xB3,0xEF,0x64,0x3B);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadExtrudedSurface,0xD7350B82,0x3736,0x44AE,0x92,0xA4,0x85,0xCC,0x17,0x74,0x9E,0xD5);


MIDL_DEFINE_GUID(IID, IID_IAcadRevolvedSurface,0xF4C25A6B,0x5851,0x4BE0,0xBF,0x3A,0xE6,0xFA,0x79,0xCB,0xE2,0xB9);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadRevolvedSurface,0x9DE83266,0xE5E0,0x4BA1,0xAF,0x80,0xB2,0xA6,0x3B,0xF6,0x30,0xCF);


MIDL_DEFINE_GUID(IID, IID_IAcadSweptSurface,0xA8016A28,0xA6AC,0x49BB,0xBE,0x8C,0x8F,0x96,0x03,0x3A,0x42,0x40);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadSweptSurface,0x190FB7CC,0x91C6,0x4948,0xB8,0x5C,0xC9,0x46,0x88,0xD7,0x53,0x24);


MIDL_DEFINE_GUID(IID, IID_IAcadLoftedSurface,0x8A5CEF4D,0x2D2D,0x42DA,0x9F,0x84,0x83,0x33,0x13,0x13,0xE5,0x02);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadLoftedSurface,0x73714CBA,0x4CB6,0x4EC8,0xB6,0xEB,0x45,0x03,0x2A,0xD1,0xFF,0x0F);


MIDL_DEFINE_GUID(IID, IID_IAcadSection,0xB579897A,0x9622,0x4EDA,0x88,0x2F,0x37,0x4D,0x74,0x67,0x48,0x1A);


MIDL_DEFINE_GUID(IID, IID_IAcadSection2,0xE09EC02D,0x2F9B,0x4E9A,0x81,0x16,0xBD,0x37,0x07,0x73,0xC6,0x86);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadSection,0x90E47ECE,0x9277,0x4524,0x96,0xFC,0x8D,0xCD,0xBC,0xB5,0xED,0xEB);


MIDL_DEFINE_GUID(IID, IID_IAcadSectionManager,0x8F65FA69,0x0A46,0x46AD,0x82,0x4C,0xE3,0xB8,0xB8,0x34,0x17,0x81);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadSectionManager,0x0E200E45,0x5A20,0x450A,0xB8,0x7A,0xE0,0xE9,0xE0,0xCB,0x4E,0xF2);


MIDL_DEFINE_GUID(IID, IID_IAcadUnderlay,0xFEC1A381,0x2B34,0x4AA6,0xBF,0xCC,0x80,0x9A,0xD6,0x48,0xD8,0x75);


MIDL_DEFINE_GUID(IID, IID_IAcadDwfUnderlay,0x474EC52B,0x6DC6,0x4025,0x80,0x1B,0x57,0x58,0x32,0xA3,0xE5,0x80);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadDwfUnderlay,0x9C5DE14C,0xC805,0x4582,0xBE,0x0F,0x20,0x94,0x1D,0xCB,0x91,0x9E);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadDgnUnderlay,0xD14ABE17,0x087D,0x4565,0xA2,0x34,0x5F,0x25,0xA5,0xDD,0xC1,0x00);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadPdfUnderlay,0x20AEBC62,0xE2C7,0x4CE3,0x86,0x30,0x33,0xDA,0xDE,0x23,0x14,0xB1);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadSubEntity,0x1C8F5F76,0xA4DF,0x4F74,0x80,0x9E,0xB4,0x8E,0xD0,0x8D,0x4D,0x0A);


MIDL_DEFINE_GUID(IID, IID_IAcadSubEntSolidFace,0xED4BFFCF,0x3FCA,0x41AB,0xA9,0xED,0x77,0xC4,0x0C,0xDA,0x32,0x0D);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadSubEntSolidFace,0x4ED71541,0xC46C,0x4A7E,0x8C,0xE3,0xF9,0xBE,0x5F,0xD6,0xD7,0x19);


MIDL_DEFINE_GUID(IID, IID_IAcadSubEntSolidEdge,0x43A1CDC7,0xAAE6,0x4585,0x93,0x06,0x6D,0x6E,0x92,0xD6,0x84,0x00);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadSubEntSolidEdge,0xA8B9AC22,0x8299,0x4E0E,0x9C,0x0F,0xDB,0xA5,0x7C,0x83,0x47,0x75);


MIDL_DEFINE_GUID(IID, IID_IAcadSubEntSolidVertex,0x2E712F3A,0x09F4,0x477B,0xAF,0xE4,0x4C,0x81,0xF9,0x29,0x14,0x4E);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadSubEntSolidVertex,0xF494B42C,0x0D99,0x4CAD,0x82,0x9B,0xBF,0x56,0x1F,0xDF,0x7A,0xB2);


MIDL_DEFINE_GUID(IID, IID_IAcadSubEntSolidNode,0xC3E9FE62,0x5252,0x4E82,0x92,0x7D,0x06,0x77,0x8B,0x3C,0x0E,0xF4);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadSubEntSolidNode,0xAA04A465,0x8507,0x4023,0x99,0x44,0x55,0xE3,0x1D,0x24,0x33,0xDA);


MIDL_DEFINE_GUID(IID, IID_IAcadWipeout,0x877F5D73,0xEB3F,0x457D,0xB0,0x31,0xDE,0x39,0x3C,0xCB,0x6E,0xE6);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadWipeout,0x44E1E732,0x8052,0x4880,0x9A,0x59,0xF7,0xEE,0xED,0x24,0x6D,0x12);


MIDL_DEFINE_GUID(IID, IID_IAcadSubDMesh,0xEC699FE7,0xE0CC,0x413A,0xA4,0xD6,0x1E,0xE6,0xBC,0x0B,0xC1,0x27);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadSubDMesh,0xF4EAB5FF,0x5C4A,0x43BC,0xBA,0x19,0x9C,0x95,0xC5,0x19,0xD8,0xAC);


MIDL_DEFINE_GUID(IID, IID_IAcadSubDMeshFace,0x30D323CE,0xFAFA,0x40F2,0xAB,0x64,0xFB,0x1D,0x53,0x95,0x7A,0x18);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadSubDMeshFace,0xE91DFDA0,0x8267,0x4145,0x82,0x04,0x57,0xEA,0x28,0x74,0x54,0x30);


MIDL_DEFINE_GUID(IID, IID_IAcadSubDMeshEdge,0x789B1F95,0xC0FA,0x4637,0x9A,0xEB,0xB5,0xA4,0xC5,0x72,0x2A,0x86);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadSubDMeshEdge,0x4FB06098,0xDB4B,0x49EF,0x9A,0x6E,0x3A,0x58,0xD3,0x8E,0x84,0x19);


MIDL_DEFINE_GUID(IID, IID_IAcadSubDMeshVertex,0xD7FC1E7C,0x616D,0x41CC,0xBA,0x4B,0x24,0x97,0x52,0x41,0xBF,0x4A);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadSubDMeshVertex,0x1CF6419C,0xEB08,0x446A,0xB2,0x1A,0x86,0x48,0xA9,0xB4,0x45,0x65);


MIDL_DEFINE_GUID(IID, IID_IAcadNurbSurface,0x627FF4D8,0x189F,0x4492,0x8E,0x24,0x03,0xF8,0xEF,0x7A,0x3E,0xE7);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadNurbSurface,0x4882BEB7,0x3E9F,0x4ED2,0x8E,0x69,0x64,0xE9,0x55,0xDA,0xFF,0x26);


MIDL_DEFINE_GUID(IID, IID_IAcadGeoPositionMarker,0xAA3C7098,0xB3B5,0x4506,0x8A,0x3A,0x50,0x23,0x09,0xA3,0x9A,0xDA);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadGeoPositionMarker,0x7093F7CB,0x516B,0x4D7A,0x99,0xD7,0x77,0xD7,0xA5,0x78,0x2C,0x4E);


MIDL_DEFINE_GUID(IID, IID_IAcadGeomapImage,0x0AF8AB47,0xB44E,0x4E1C,0x92,0xEF,0x20,0xEC,0x02,0x02,0xC3,0xBD);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadGeomapImage,0x9C0E5023,0x7125,0x4669,0xBE,0x1A,0x4A,0xED,0x4C,0xC5,0x64,0x15);


MIDL_DEFINE_GUID(IID, IID_IAcadDimension,0x32DC7EFF,0x0B32,0x485B,0x87,0xAC,0x14,0x3A,0xC5,0x54,0x32,0x7F);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadDimension,0x69397113,0x68A3,0x4B89,0xBD,0xEE,0x52,0xEE,0x68,0x19,0x61,0x9F);


MIDL_DEFINE_GUID(IID, IID_IAcadDimAligned,0xFE96D5C6,0xE074,0x40E2,0xB5,0xA9,0x1C,0x6B,0x3A,0x26,0x85,0xD9);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadDimAligned,0x6B6E4A11,0x1124,0x479D,0xA7,0xF6,0xE2,0x62,0xE9,0x92,0x05,0x09);


MIDL_DEFINE_GUID(IID, IID_IAcadDimAngular,0x54EB2A86,0x111D,0x4BAA,0xAA,0x31,0xAF,0x4A,0xE4,0x1B,0x24,0x3B);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadDimAngular,0x82B477F1,0xE82B,0x4359,0xA2,0x2A,0x4A,0x7A,0x61,0xBE,0x9B,0x13);


MIDL_DEFINE_GUID(IID, IID_IAcadDimDiametric,0x3C2370AE,0x2726,0x439E,0xA7,0xDF,0xB1,0x05,0xA8,0x73,0xC4,0xC5);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadDimDiametric,0x3DDD61F5,0xBC51,0x4D70,0x89,0x67,0x45,0xD3,0x0E,0x36,0x1D,0xCB);


MIDL_DEFINE_GUID(IID, IID_IAcadDimOrdinate,0xD17152C0,0x5E08,0x4B20,0xB4,0xD0,0xFF,0x31,0x12,0x8B,0x7D,0xD5);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadDimOrdinate,0x394031EA,0x6D74,0x45F5,0xAB,0xF1,0x81,0x90,0x5B,0x6D,0x94,0xA8);


MIDL_DEFINE_GUID(IID, IID_IAcadDimRadial,0xF7091A11,0x4900,0x460D,0x84,0xF4,0xC2,0x37,0xB4,0x30,0xFC,0xA3);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadDimRadial,0x40118472,0xDA0A,0x4927,0x90,0x3A,0xF4,0xBC,0xBA,0xD4,0x54,0xA0);


MIDL_DEFINE_GUID(IID, IID_IAcadDimRotated,0x5A1F1FF1,0xABCE,0x4D0B,0xBE,0xD3,0xCE,0x92,0xC1,0xC3,0x75,0xB9);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadDimRotated,0x3DC84993,0xE894,0x4272,0xB3,0x77,0x52,0xA0,0x1E,0xEB,0x7F,0xC5);


MIDL_DEFINE_GUID(IID, IID_IAcadDim3PointAngular,0xFCB6F2AC,0x1BB7,0x41B1,0x9F,0xAB,0xB7,0x11,0x3F,0x60,0x71,0x20);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadDim3PointAngular,0xD8374A04,0x9DD9,0x4912,0x84,0x3D,0xD5,0xC2,0xE2,0x3B,0xC4,0x77);


MIDL_DEFINE_GUID(IID, IID_IAcadDimArcLength,0xA65DE775,0x8DAE,0x4D2D,0xAF,0xF2,0x73,0xE5,0xF7,0xEF,0x3B,0xC8);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadDimArcLength,0x89939DBF,0x8C75,0x4CDF,0xB0,0x0D,0x3F,0xFC,0x27,0xDC,0x79,0x11);


MIDL_DEFINE_GUID(IID, IID_IAcadDimRadialLarge,0x9DE62AD0,0x6CC6,0x4E96,0x90,0xC6,0xD0,0xA0,0x56,0x49,0x33,0xFD);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadDimRadialLarge,0x254A0B97,0x1A90,0x4C56,0xB0,0x95,0xCC,0x9B,0x7C,0x24,0xB8,0xB8);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadBlock,0x95CC3A4D,0x8E7B,0x4F13,0xA8,0x99,0xFA,0x1F,0xB2,0xF6,0xA0,0xE1);


MIDL_DEFINE_GUID(IID, IID_IAcadModelSpace,0x1BD75629,0xE597,0x4154,0x83,0xE8,0xE7,0xDD,0x2C,0xEB,0xDD,0x08);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadModelSpace,0xFE616360,0x1748,0x440F,0xB1,0x43,0x98,0xD7,0xE2,0xE9,0x28,0xF6);


MIDL_DEFINE_GUID(IID, IID_IAcadPaperSpace,0x80F60F17,0x54D4,0x4F17,0xA6,0x59,0x80,0x97,0x9C,0x41,0x1D,0x63);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadPaperSpace,0x08D5B2B1,0xBBC3,0x45BE,0x80,0xED,0x52,0x8B,0x9B,0x98,0x23,0x8F);


MIDL_DEFINE_GUID(IID, IID_IAcadPointCloud,0x4A6AE902,0xA182,0x455B,0x9D,0x97,0x37,0xFF,0x71,0x68,0x38,0xA9);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadPointCloud,0x1B166B76,0x11E2,0x421E,0x9C,0xB7,0x9F,0x8F,0x10,0x52,0xDA,0x80);


MIDL_DEFINE_GUID(IID, IID_IAcadPointCloudEx,0x3BA3B05C,0xDFF6,0x45B8,0x80,0xC9,0x89,0x0A,0x30,0xF8,0xC2,0x06);


MIDL_DEFINE_GUID(IID, IID_IAcadPointCloudEx2,0x5575D931,0x0FEA,0x4450,0xBC,0xA1,0x53,0x28,0xE5,0xBE,0x96,0x22);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadPointCloudEx,0xF751B1AC,0x976C,0x4F40,0x96,0x40,0x5B,0xDD,0xA7,0xF3,0x05,0x8C);


MIDL_DEFINE_GUID(IID, IID_IAcadFileDependency,0xAF690CAA,0xE5BD,0x4018,0x88,0x95,0xCE,0xBE,0x14,0x71,0x02,0x73);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadFileDependency,0xEE2AB753,0x9CD9,0x489D,0xAC,0xFF,0xBC,0xC6,0x29,0x3A,0x0E,0xDD);


MIDL_DEFINE_GUID(IID, IID_IAcadFileDependencies,0xBFCDB061,0x5A7A,0x4CEA,0xAB,0x7A,0xB4,0x11,0x69,0xEC,0x4A,0xAE);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadFileDependencies,0x994B535A,0x3851,0x449F,0x86,0xE4,0x2F,0x7A,0x64,0xDB,0xEE,0xFF);


MIDL_DEFINE_GUID(IID, IID_IAcadSummaryInfo,0x02E39B0D,0x6527,0x453B,0xB2,0xFF,0xC3,0xA3,0x18,0x95,0xA3,0xA4);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadSummaryInfo,0xFDD1E36E,0xBA8A,0x4BB5,0xBC,0x8A,0x0F,0xA6,0xB0,0x4B,0x82,0xAF);


MIDL_DEFINE_GUID(IID, IID_IAcadDatabasePreferences,0x14B4D107,0xE467,0x45F9,0x88,0x4E,0x0B,0x72,0xC6,0x97,0x54,0x11);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadDatabasePreferences,0x21484BD2,0xEDEE,0x4131,0x92,0xBE,0xEB,0x49,0x7B,0x28,0x6B,0x06);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadDatabase,0x3FC88B89,0x3C97,0x492F,0x83,0xF8,0xA5,0x3B,0x5F,0x63,0xCE,0xEE);


MIDL_DEFINE_GUID(IID, IID_IAcadSecurityParams,0x88C42A3E,0xE8B4,0x4B5D,0xA8,0xB3,0xAC,0x3B,0x04,0x8B,0x55,0x81);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadSecurityParams,0x26DA3C63,0xBEB3,0x4B9B,0x8B,0xB5,0x00,0x8C,0x7D,0x96,0x16,0x31);


MIDL_DEFINE_GUID(IID, IID_IAcadLayerStateManager,0x9139F344,0xEF7A,0x4AF4,0xA5,0xF5,0x0B,0x00,0x57,0xA7,0x7F,0x84);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadLayerStateManager,0x3D17F248,0x35E7,0x4DFD,0x9C,0x65,0x90,0xEE,0x72,0x59,0x38,0xE7);


MIDL_DEFINE_GUID(IID, DIID__DAcadApplicationEvents,0x006CFD3B,0x443B,0x4A18,0xB0,0x71,0xD5,0xC7,0xC6,0xE6,0x34,0x4C);


MIDL_DEFINE_GUID(IID, IID_IAcadDocument,0xF56F6A35,0x29BD,0x4F08,0x9A,0x94,0x67,0x5D,0x39,0x1D,0x17,0xD8);


MIDL_DEFINE_GUID(IID, IID_IAcadDocuments,0x0D0D723E,0x0450,0x4237,0xAB,0x8B,0xF7,0x49,0xD9,0x99,0xC2,0xD4);


MIDL_DEFINE_GUID(IID, IID_IAcadPreferences,0xE208B0FB,0xC9E4,0x4EEC,0x83,0xA5,0x9B,0xE1,0x8F,0x25,0x26,0xFA);


MIDL_DEFINE_GUID(IID, IID_IAcadMenuGroups,0x511E5B00,0x2011,0x4743,0xA1,0x7D,0x04,0xB1,0xB7,0x3B,0x5F,0xEE);


MIDL_DEFINE_GUID(IID, IID_IAcadMenuBar,0x76AEF2A0,0x5441,0x48FA,0xA3,0x76,0xA1,0x6C,0xAD,0xF0,0xAA,0x54);


MIDL_DEFINE_GUID(IID, IID_IAcadApplication,0x10E73D12,0xA037,0x47E5,0x84,0x64,0x9B,0x07,0x16,0xBE,0x39,0x90);


MIDL_DEFINE_GUID(IID, IID_IAcadState,0xA73358EF,0xB473,0x41C8,0xB4,0xF3,0x51,0x1F,0xF6,0xA7,0x35,0x51);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadState,0x5BFE14C9,0x296D,0x4D89,0xB2,0x88,0x73,0xBF,0x4A,0x38,0xF6,0x2D);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadApplication,0x0D327DA6,0xB4DF,0x4842,0xB8,0x33,0x2C,0xFF,0x84,0xF0,0x94,0x8F);


MIDL_DEFINE_GUID(IID, IID_IAcadSelectionSet,0xD41B23A8,0x65EC,0x4A3B,0x97,0x48,0x8A,0xF4,0x60,0xAC,0x9A,0x04);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadSelectionSet,0x270E24A7,0x8932,0x4B28,0xAD,0x38,0x86,0x55,0x68,0x02,0x76,0xF9);


MIDL_DEFINE_GUID(IID, IID_IAcadSelectionSets,0x2FC118BA,0x93F5,0x4F55,0xAB,0x53,0x6C,0x9F,0x15,0xCC,0x46,0xBE);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadSelectionSets,0x1128E12D,0xDE62,0x482C,0x87,0xDB,0xB0,0xBA,0xBC,0x33,0x9B,0x26);


MIDL_DEFINE_GUID(IID, IID_IAcadPlot,0x607575D8,0x45C6,0x47D8,0x9B,0x27,0xE3,0x36,0xD9,0x8A,0x57,0x5B);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadPlot,0x05FEBF18,0x8AFD,0x428A,0x82,0x6F,0xC4,0xE8,0x22,0x40,0x02,0x25);


MIDL_DEFINE_GUID(IID, IID_IAcadPreferencesFiles,0x39F6CA67,0x76A3,0x4230,0xA2,0xE2,0x0D,0x6A,0x1D,0x9A,0xA6,0xE2);


MIDL_DEFINE_GUID(IID, IID_IAcadPreferencesDisplay,0x787626FB,0x0434,0x4B13,0x86,0x95,0x79,0x14,0xF6,0x4A,0x2C,0x6A);


MIDL_DEFINE_GUID(IID, IID_IAcadPreferencesOpenSave,0x41A3180B,0x3B06,0x4EF8,0x87,0x2E,0x6C,0x88,0x5B,0xFA,0x93,0xE1);


MIDL_DEFINE_GUID(IID, IID_IAcadPreferencesUser,0x27353C7B,0x522D,0x4317,0xAE,0x77,0xDA,0x74,0x6B,0x79,0x3E,0x00);


MIDL_DEFINE_GUID(IID, IID_IAcadPreferencesProfiles,0xCB79F8A6,0x8471,0x4952,0x94,0x01,0x7F,0xD9,0x69,0xAF,0x4F,0x42);


MIDL_DEFINE_GUID(IID, IID_IAcadPreferencesDrafting,0x89175DDB,0xAFCB,0x4C16,0xA6,0x53,0x69,0x5D,0xC0,0x08,0xA8,0xC4);


MIDL_DEFINE_GUID(IID, IID_IAcadPreferencesOutput,0x392783EB,0xAEB3,0x49BC,0xA5,0xB0,0xD6,0xBD,0x61,0x37,0xD0,0x8A);


MIDL_DEFINE_GUID(IID, IID_IAcadPreferencesSelection,0xA80CB224,0x8DD6,0x45E7,0x8C,0x46,0xFD,0x96,0x12,0xD0,0x42,0x5A);


MIDL_DEFINE_GUID(IID, IID_IAcadPreferencesSystem,0x565CBF98,0x9A44,0x4858,0x84,0xEB,0xAC,0xB2,0xB3,0xE9,0xBA,0xC0);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadPreferences,0xF99055F3,0x20C1,0x4F2A,0x9F,0xB9,0xB4,0xF0,0xA0,0xC2,0x8C,0x20);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadPreferencesDrafting,0x6997257A,0x0A52,0x4801,0xB7,0xAD,0x13,0x3E,0xB4,0x4E,0xEE,0xAB);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadPreferencesDisplay,0x47C4B163,0xBB1F,0x4060,0xA9,0xE4,0x52,0xC6,0x9E,0x5F,0x49,0x6E);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadPreferencesFiles,0x43B84872,0x9D9C,0x48C9,0xAF,0x02,0x65,0x53,0x46,0x6E,0x50,0x36);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadPreferencesOpenSave,0x7BC98F0B,0x76D8,0x480D,0x84,0xE8,0x85,0x8E,0x2B,0xDC,0xCB,0x28);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadPreferencesOutput,0xCDBB29DE,0x7DD3,0x4008,0xAE,0x0C,0xA1,0x07,0x8E,0xCA,0xA6,0x8C);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadPreferencesProfiles,0x454F2B83,0x82C4,0x49C5,0xA6,0x33,0xB9,0x67,0x35,0xBC,0x97,0xB4);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadPreferencesSelection,0x36466982,0x3BDE,0x4243,0x96,0x1F,0xCA,0xCC,0x33,0x2E,0x5F,0x95);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadPreferencesSystem,0x02DF4D76,0xDB78,0x4BF5,0xA0,0xC9,0xFA,0x19,0x18,0x56,0x6E,0x50);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadPreferencesUser,0x4C7D8B0E,0x2B24,0x41C8,0x8A,0xDF,0x6D,0x78,0xB5,0xBD,0xDA,0x35);


MIDL_DEFINE_GUID(IID, IID_IAcadMenuGroup,0xE2A5FD54,0x30A1,0x4C32,0x9A,0xD7,0x60,0xAF,0xC8,0x1E,0xA5,0xF7);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadMenuGroups,0x0FD5DD80,0x6C6B,0x4693,0xA5,0xFA,0x3E,0x8B,0x8F,0x1F,0xD2,0x62);


MIDL_DEFINE_GUID(IID, IID_IAcadPopupMenus,0x40252DA3,0xE9AD,0x4EBA,0xB0,0x41,0xA8,0x7A,0x5F,0x93,0x6A,0xF2);


MIDL_DEFINE_GUID(IID, IID_IAcadToolbars,0x0D22A122,0x3D70,0x412D,0x97,0x40,0x3E,0x79,0x8E,0x8C,0x84,0xA9);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadMenuGroup,0x91990DF3,0xEBF5,0x4A19,0xA6,0x19,0x38,0x63,0x29,0x0D,0x9E,0x33);


MIDL_DEFINE_GUID(IID, IID_IAcadPopupMenu,0x65A0AC97,0x19A0,0x4BC2,0x8C,0x2C,0xCA,0x9E,0x8A,0x71,0xC1,0xF1);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadMenuBar,0x686343D8,0xEC00,0x4AB7,0xAA,0x2E,0x38,0xCC,0x2C,0x18,0xDF,0xB0);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadPopupMenus,0x84347500,0x3B71,0x4BEA,0xA0,0x00,0xDA,0x0B,0x37,0x3C,0x75,0xBE);


MIDL_DEFINE_GUID(IID, IID_IAcadPopupMenuItem,0x4F445722,0xDC88,0x4DB3,0x8F,0xE8,0x82,0x5A,0x75,0xD0,0x0B,0x61);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadPopupMenu,0x089CB5FD,0x692E,0x48E4,0xBA,0xF4,0x71,0xCF,0x75,0xCB,0x4F,0x58);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadPopupMenuItem,0x5B6122A4,0xE83A,0x4E39,0x8E,0x0B,0x74,0x3C,0xF6,0x92,0x92,0xF4);


MIDL_DEFINE_GUID(IID, IID_IAcadUtility,0xE089152B,0x8F17,0x4894,0xBE,0x58,0xBD,0x37,0x0E,0xFC,0x91,0x82);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadUtility,0x5222EDD7,0x4C51,0x4417,0xA3,0x40,0xAC,0xED,0xAB,0x69,0xEA,0x77);


MIDL_DEFINE_GUID(IID, DIID__DAcadDocumentEvents,0x6DD95E15,0x2448,0x48B0,0x87,0x1F,0xA4,0xAF,0xDC,0xEF,0x43,0x9C);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadDocument,0x720DB9AF,0xD62C,0x4ED0,0xA3,0x77,0x42,0x9C,0x22,0x31,0x28,0x52);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadDocuments,0x46F2D47E,0xB78B,0x490C,0xAF,0x25,0xB8,0xDC,0x8D,0x70,0x81,0xDB);


MIDL_DEFINE_GUID(IID, IID_IAcadToolbar,0xB5877356,0x2591,0x447B,0x80,0x78,0x16,0x1D,0xB7,0xDF,0xE1,0x61);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadToolbars,0xAA169F21,0x8C69,0x4393,0xB9,0xBD,0xD4,0x47,0xB7,0x96,0xD8,0x8D);


MIDL_DEFINE_GUID(IID, IID_IAcadToolbarItem,0xAFE78F7E,0x75D3,0x4E08,0x86,0xFA,0x44,0x88,0x33,0x49,0x64,0x6D);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadToolbar,0xC642D5E6,0x3F92,0x410A,0xA2,0x4E,0xD4,0xA6,0x19,0xA3,0x29,0xF9);


MIDL_DEFINE_GUID(CLSID, CLSID_AcadToolbarItem,0x3B4318A1,0x112D,0x4849,0x91,0x96,0x5F,0x3A,0x6F,0x98,0xEF,0x54);

#undef MIDL_DEFINE_GUID

#ifdef __cplusplus
}
#endif



