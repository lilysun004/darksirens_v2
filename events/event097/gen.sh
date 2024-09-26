lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 31.783503503503503 --fixed-mass2 78.93221221221222 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1017921034.4503127 \
--gps-end-time 1017928234.4503127 \
--d-distr volume \
--min-distance 1429.4540203787788e3 --max-distance 1429.4740203787787e3 \
--l-distr fixed --longitude 30.246231079101562 --latitude -11.983940124511719 --i-distr uniform \
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
