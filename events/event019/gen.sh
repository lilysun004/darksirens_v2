lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 35.48144144144145 --fixed-mass2 37.07827827827828 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1014257778.4553918 \
--gps-end-time 1014264978.4553918 \
--d-distr volume \
--min-distance 1570.0264451673418e3 --max-distance 1570.0464451673417e3 \
--l-distr fixed --longitude -153.93824768066406 --latitude 42.49707794189453 --i-distr uniform \
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
