lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 19.513073073073073 --fixed-mass2 10.436316316316315 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1011932240.821054 \
--gps-end-time 1011939440.821054 \
--d-distr volume \
--min-distance 920.8684907037486e3 --max-distance 920.8884907037486e3 \
--l-distr fixed --longitude -66.39080810546875 --latitude 8.241787910461426 --i-distr uniform \
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
