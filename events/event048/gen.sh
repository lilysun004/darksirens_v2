lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 7.999039039039039 --fixed-mass2 32.035635635635636 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1025602309.8680052 \
--gps-end-time 1025609509.8680052 \
--d-distr volume \
--min-distance 1052.009991197682e3 --max-distance 1052.029991197682e3 \
--l-distr fixed --longitude 139.2936553955078 --latitude 1.7633048295974731 --i-distr uniform \
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
