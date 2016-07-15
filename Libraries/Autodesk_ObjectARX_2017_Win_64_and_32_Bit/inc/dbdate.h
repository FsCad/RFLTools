//
//////////////////////////////////////////////////////////////////////////////
//
//  Copyright 2016 Autodesk, Inc.  All rights reserved.
//
//  Use of this software is subject to the terms of the Autodesk license 
//  agreement provided at the time of installation or download, or which 
//  otherwise accompanies this software in either electronic or hard copy form.   
//
//////////////////////////////////////////////////////////////////////////////
//
//
// DESCRIPTION: API for date class.

#ifndef AD_DBDATE_H
#define AD_DBDATE_H

#include "acdb.h"

#pragma pack(push, 8)

class AcDbDwgFiler;
typedef struct _SYSTEMTIME SYSTEMTIME;

class AcDbDate
{
public:
    enum InitialValue {
        kInitZero          = 1,
        kInitLocalTime     = 2,
        kInitUniversalTime = 3
    };
    AcDbDate();
    AcDbDate(InitialValue i);
    AcDbDate(const AcDbDate&);
    virtual ~AcDbDate();

    const AcDbDate& operator= (const AcDbDate&);

    // Get and set the date.
    //
    void  getDate (short& month, short& day, short& year) const;
    AcString getLocalDisplayString() const;
    void  setDate (short month, short day, short year);
    short month   () const;
    void  setMonth(short);
    short day     () const;
    void  setDay  (short);
    short year    () const;
    void  setYear (short);

    ACDB_PORT void  getTime(SYSTEMTIME &st) const;
    void  getTime (std::tm &st) const;
    void  setTime(const std::tm &st);
    void  getTime (time_t &st) const;
    ACDB_PORT void  setTime(const SYSTEMTIME &st);


    // Get and set the time.
    //
    void  getTime  (short& hour, short& min, short& sec, short& msec) const;
    void  setTime  (short hour, short min, short sec, short msec);

    // The "approximate time" is the current time of day expressed in 15 minute units
    // E.g. 2:15am is 5, 10:20am is 42, etc
    //
    int getApproximateTime () const;
    void setApproximateTime (int time);

    short hour     () const;
    void  setHour  (short);
    short minute   () const;
    void  setMinute(short);
    short second   () const;
    void  setSecond(short);
    short millisecond() const;
    void  setMillisecond(short);
    void  setToZero();

    // Initialize with current time.
    //
    void  getLocalTime();
    void  getUniversalTime();

    // Convert between local and universal time
    //
    void localToUniversal();
    void universalToLocal();
 
    // Get/Set Julian representation for the date.
    // Julian "day zero" is noon GMT 1/1/4713 BC
    // 1/1/2000 is 0x256859 (2,451,545)
    // 1/1/2020 is 0x2584e2 (2,458,850)
    //
    Adesk::Int32   julianDay           () const;
    Adesk::Int32   msecsPastMidnight   () const;
    void   setJulianDay        (Adesk::Int32 julianDay);
    void   setMsecsPastMidnight(Adesk::Int32 msec);
    void   setJulianDate       (Adesk::Int32 julianDay, Adesk::Int32 msec);
    double julianFraction      () const;
    void   setJulianFraction   (double);
 
    // Boolean comparison operators
    //
    bool operator== (const AcDbDate&) const;
    bool operator > (const AcDbDate&) const;
    bool operator >= (const AcDbDate&) const;
    bool operator < (const AcDbDate&) const;
    bool operator <= (const AcDbDate&) const;

    // Arithmetic operators.
    //
    const AcDbDate operator + (const AcDbDate &date) const;
    const AcDbDate operator - (const AcDbDate &date) const;
    const AcDbDate & operator += (const AcDbDate &date);
    const AcDbDate & operator -= (const AcDbDate &date);

    // Obsolete.  Please use += or -= operators.
    const AcDbDate& add      (const AcDbDate &date);
    const AcDbDate& subtract (const AcDbDate &date);

    // Dwg in and out.
    //
    Acad::ErrorStatus dwgOut(AcDbDwgFiler *outFiler) const;
    Acad::ErrorStatus dwgIn (AcDbDwgFiler *inFiler);

private:
    friend class AcDbImpDate;
    class AcDbImpDate *mpImpDate;
};

inline const AcDbDate AcDbDate::operator + (const AcDbDate & d) const
{
    return AcDbDate(*this) += d;
}

inline const AcDbDate AcDbDate::operator - (const AcDbDate & d) const
{
    return AcDbDate(*this) -= d;
}

inline bool AcDbDate::operator < (const AcDbDate & d) const
{
    return ! operator >= (d);
}

inline bool AcDbDate::operator <= (const AcDbDate & d) const
{
    return ! operator > (d);
}

inline const AcDbDate & AcDbDate::add(const AcDbDate &date)
{
    return operator += (date);
}

inline const AcDbDate & AcDbDate::subtract(const AcDbDate &date)
{
    return operator -= (date);
}

#pragma pack(pop)

#endif

