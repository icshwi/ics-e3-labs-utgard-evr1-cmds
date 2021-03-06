epicsEnvSet("SYS", "LabS-Utgard-VIP:TS")
epicsEnvSet("PCI_SLOT", "5:0.0")
epicsEnvSet("DEVICE", "EVR-1")
epicsEnvSet("EVR", "$(DEVICE)")
epicsEnvSet("CHIC_SYS", "LabS-Utgard-VIP:")
epicsEnvSet("CHOP_DRV", "Chop-Drv-01")
epicsEnvSet("CHIC_DEV", "TS-$(DEVICE)")
epicsEnvSet("MRF_HW_DB", "evr-pcie-300dc-ess.db")
epicsEnvSet("E3_MODULES", "/home/root/epics/iocs/e3")
epicsEnvSet("EPICS_CMDS", "/home/root/epics/iocs/cmds")

######## Temporary until chopper group ###########
######## changes PV names              ###########
epicsEnvSet("NCG_SYS", "LabS-VIP:")
# Change to 01a: to avoid conflict with EVR2 names
epicsEnvSet("NCG_DRV", "Chop-Drv-01a:")
##################################################

< "$(EPICS_CMDS)/mrfioc2-common/st.evr.cmd"

# Set delay compensation target. This is required even when delay compensation
# is disabled to avoid occasionally corrupting timestamps.
#dbpf $(SYS)-$(DEVICE):DC-Tgt-SP 70
dbpf $(SYS)-$(DEVICE):DC-Tgt-SP 100

######### INPUTS #########

# Set up of UnivIO 0 as Input. Generate Code 10 locally on rising edge.
dbpf $(SYS)-$(DEVICE):In0-Lvl-Sel "Active High"
dbpf $(SYS)-$(DEVICE):In0-Edge-Sel "Active Rising"
dbpf $(SYS)-$(DEVICE):OutFPUV00-Src-SP 61
dbpf $(SYS)-$(DEVICE):In0-Trig-Ext-Sel "Edge"
dbpf $(SYS)-$(DEVICE):In0-Code-Ext-SP 10
dbpf $(SYS)-$(DEVICE):EvtA-SP.OUT "@OBJ=$(EVR),Code=10"
dbpf $(SYS)-$(DEVICE):EvtA-SP.VAL 10

# Set up of UnivIO 1 as Input. Generate Code 11 locally on rising edge.
dbpf $(SYS)-$(DEVICE):In1-Lvl-Sel "Active High"
dbpf $(SYS)-$(DEVICE):In1-Edge-Sel "Active Rising"
dbpf $(SYS)-$(DEVICE):OutFPUV01-Src-SP 61
dbpf $(SYS)-$(DEVICE):In1-Trig-Ext-Sel "Edge"
dbpf $(SYS)-$(DEVICE):In1-Code-Ext-SP 11
dbpf $(SYS)-$(DEVICE):EvtB-SP.OUT "@OBJ=$(EVR),Code=11"
dbpf $(SYS)-$(DEVICE):EvtB-SP.VAL 11

######### OUTPUTS #########
dbpf $(SYS)-$(DEVICE):DlyGen1-Evt-Trig0-SP 14
dbpf $(SYS)-$(DEVICE):DlyGen1-Width-SP 2860 #1ms
dbpf $(SYS)-$(DEVICE):DlyGen1-Delay-SP 0 #0ms
dbpf $(SYS)-$(DEVICE):OutFPUV03-Src-SP 1 #Connect output2 to DlyGen-1

#Set up delay generator 2 to trigger on event 16
dbpf $(SYS)-$(DEVICE):DlyGen2-Width-SP 1000 #1ms
dbpf $(SYS)-$(DEVICE):DlyGen2-Delay-SP 0 #0ms
dbpf $(SYS)-$(DEVICE):DlyGen2-Evt-Trig0-SP 16

#Set up delay generator 0 to trigger on event 17 and set universal I/O 2
dbpf $(SYS)-$(DEVICE):DlyGen0-Width-SP 1000 #1ms
dbpf $(SYS)-$(DEVICE):DlyGen0-Delay-SP 0 #0ms
dbpf $(SYS)-$(DEVICE):DlyGen0-Evt-Trig0-SP 17
dbpf $(SYS)-$(DEVICE):OutFPUV02-Src-SP 0 #Connect to DlyGen-0

######## Sequencer #########
# Select trigger source for soft seq 0, trigger source 0, 2 means pulser 2
dbpf $(SYS)-$(DEVICE):SoftSeq0-TrigSrc-0-Sel 2

# Load sequencer setup
dbpf $(SYS)-$(DEVICE):SoftSeq0-Load-Cmd 1

# Enable sequencer
dbpf $(SYS)-$(DEVICE):SoftSeq0-Enable-Cmd 1

dbpf $(CHIC_SYS)$(CHOP_DRV)01:Freq-SP 28
dbpf $(CHIC_SYS)$(CHOP_DRV)02:Freq-SP 28
dbpf $(CHIC_SYS)$(CHOP_DRV)03:Tube-Pos-Delay 10
dbpf $(CHIC_SYS)$(CHOP_DRV)04:Tube-Pos-Delay 20
# Check that this command is required.
dbpf $(SYS)-$(DEVICE):RF-Freq 88052500

# Hints for setting input PVs from client
#caput -a $(SYS)-$(DEVICE):SoftSeq0-EvtCode-SP 2 17 18
#caput -a $(SYS)-$(DEVICE):SoftSeq0-Timestamp-SP 2 0 12578845
#caput -n $(SYS)-$(DEVICE):SoftSeq0-Commit-Cmd 1

######### TIME STAMP #########

#Forward links to esschicTimestampBuffer.template
#dbpf $(SYS)-$(DEVICE):EvtACnt-I.FLNK $(CHIC_SYS)$(CHOP_DRV):TDC
#dbpf $(SYS)-$(DEVICE):EvtECnt-I.FLNK $(CHIC_SYS)$(CHOP_DRV):Ref

#dbpf $(SYS)-$(DEVICE):EvtBCnt-I.FLNK $(CHIC_SYS)$(CHOP_DRV):TDC
#dbpf $(CHIC_SYS)$(CHOP_DRV)01:BPFO.LNK3 $(CHIC_SYS)$(CHOP_DRV):Ref


