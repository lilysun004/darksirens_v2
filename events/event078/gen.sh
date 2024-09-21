lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 29.346226226226225 --fixed-mass2 64.22450450450451 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1000163253.0990653 \
--gps-end-time 1000170453.0990653 \
--d-distr volume \
--min-distance 1217.7017387953333e3 --max-distance 1217.7217387953333e3 \
--l-distr fixed --longitude -155.82904052734375 --latitude 15.557275772094727 --i-distr uniform \
--f-lower 20 --disable-spin \
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \
-o psd.xml \
--H1=aLIGOZeroDetHighPower \
--L1=aLIGOZeroDetHighPower \
--V1=AdvVirgo

bayestar-realize-coincs \
-o coinc.xml \
inj.xml --reference-psd psd.xml \
--detector H1 L1 V1 \
--measurement-error gaussian-noise \
--snr-threshold 4.0 \
--net-snr-threshold 12.0 \
--min-triggers 2 \
--keep-subthreshold

bayestar-localize-coincs coinc.xml
