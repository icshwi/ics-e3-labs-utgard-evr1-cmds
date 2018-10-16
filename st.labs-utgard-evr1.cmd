epicsEnvSet("SYS", "LabS-Utgard-VIP:TS")
epicsEnvSet("PCI_SLOT", "5:0.0")
epicsEnvSet("DEVICE", "EVR-1")
epicsEnvSet("EVR", "$(DEVICE)")
epicsEnvSet("CHIC_SYS", "LabS-Utgard-VIP:")
epicsEnvSet("CHOP_DRV", "Chop-Drv-01")
epicsEnvSet("CHIC_DEV", "TS-$(DEVICE)")

epicsEnvSet("E3_MODULES", "/home/root/vip/epics/iocs/e3")
epicsEnvSet("EPICS_CMDS", "/home/root/vip/epics/iocs/cmds")

< "$(EPICS_CMDS)/mrfioc2-common/st.evr.cmd"

