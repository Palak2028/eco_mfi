package com.infrasofttech.eco_mfi;


import java.time.LocalDateTime;

public class SavingsListBean {


    private int trefno = 0;
    private int mrefno;
    private int mlbrcode;
    private int mcusttrefno;
    private int mcustmrefno;
    private String mprdacctid;
    private String mmobno;
    private String mlongname;
    private String mcurcd;
    private String mprdcd;

    public int getTrefno() {
        return trefno;
    }

    public void setTrefno(int trefno) {
        this.trefno = trefno;
    }

    public int getMrefno() {
        return mrefno;
    }

    public void setMrefno(int mrefno) {
        this.mrefno = mrefno;
    }

    public int getMlbrcode() {
        return mlbrcode;
    }

    public void setMlbrcode(int mlbrcode) {
        this.mlbrcode = mlbrcode;
    }

    public int getMcusttrefno() {
        return mcusttrefno;
    }

    public void setMcusttrefno(int mcusttrefno) {
        this.mcusttrefno = mcusttrefno;
    }

    public int getMcustmrefno() {
        return mcustmrefno;
    }

    public void setMcustmrefno(int mcustmrefno) {
        this.mcustmrefno = mcustmrefno;
    }

    public String getMprdacctid() {
        return mprdacctid;
    }

    public void setMprdacctid(String mprdacctid) {
        this.mprdacctid = mprdacctid;
    }

    public String getMmobno() {
        return mmobno;
    }

    public void setMmobno(String mmobno) {
        this.mmobno = mmobno;
    }

    public String getMlongname() {
        return mlongname;
    }

    public void setMlongname(String mlongname) {
        this.mlongname = mlongname;
    }

    public String getMcurcd() {
        return mcurcd;
    }

    public void setMcurcd(String mcurcd) {
        this.mcurcd = mcurcd;
    }

    public String getMprdcd() {
        return mprdcd;
    }

    public void setMprdcd(String mprdcd) {
        this.mprdcd = mprdcd;
    }

    public LocalDateTime getMdateopen() {
        return mdateopen;
    }

    public void setMdateopen(LocalDateTime mdateopen) {
        this.mdateopen = mdateopen;
    }

    public LocalDateTime getMdateclosed() {
        return mdateclosed;
    }

    public void setMdateclosed(LocalDateTime mdateclosed) {
        this.mdateclosed = mdateclosed;
    }

    public int getMfreezetype() {
        return mfreezetype;
    }

    public void setMfreezetype(int mfreezetype) {
        this.mfreezetype = mfreezetype;
    }

    public int getMacctstat() {
        return macctstat;
    }

    public void setMacctstat(int macctstat) {
        this.macctstat = macctstat;
    }

    public int getMcustno() {
        return mcustno;
    }

    public void setMcustno(int mcustno) {
        this.mcustno = mcustno;
    }

    public double getMactTotbalfcy() {
        return mactTotbalfcy;
    }

    public void setMactTotbalfcy(double mactTotbalfcy) {
        this.mactTotbalfcy = mactTotbalfcy;
    }

    public double getMtotallienfcy() {
        return mtotallienfcy;
    }

    public void setMtotallienfcy(double mtotallienfcy) {
        this.mtotallienfcy = mtotallienfcy;
    }

    public int getMmoduletype() {
        return mmoduletype;
    }

    public void setMmoduletype(int mmoduletype) {
        this.mmoduletype = mmoduletype;
    }

    public String getMerrormessage() {
        return merrormessage;
    }

    public void setMerrormessage(String merrormessage) {
        this.merrormessage = merrormessage;
    }

    public int getMcenterid() {
        return mcenterid;
    }

    public void setMcenterid(int mcenterid) {
        this.mcenterid = mcenterid;
    }

    public int getMgroupcd() {
        return mgroupcd;
    }

    public void setMgroupcd(int mgroupcd) {
        this.mgroupcd = mgroupcd;
    }

    public String getMcrs() {
        return mcrs;
    }

    public void setMcrs(String mcrs) {
        this.mcrs = mcrs;
    }

    private LocalDateTime mdateopen;
    private LocalDateTime mdateclosed;
    private int mfreezetype;
    private int macctstat;
    private int mcustno;
    private double mactTotbalfcy = 0d;
    private double mtotallienfcy = 0d;
    private int mmoduletype;
    private String merrormessage = "";
    private int mcenterid;
    private int mgroupcd;
    private String mcrs;


}
