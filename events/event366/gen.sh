lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 55.90414414414415 --fixed-mass2 48.76040040040041 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1020038612.7851723 \
--gps-end-time 1020045812.7851723 \
--d-distr volume \
--min-distance 1962.2043425534882e3 --max-distance 1962.2243425534882e3 \
--l-distr fixed --longitude 107.72156524658203 --latitude 29.370281219482422 --i-distr uniform \
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
