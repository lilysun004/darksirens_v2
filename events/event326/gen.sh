lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 24.135495495495494 --fixed-mass2 44.05393393393393 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1017233052.1012013 \
--gps-end-time 1017240252.1012013 \
--d-distr volume \
--min-distance 1133.7900226010447e3 --max-distance 1133.8100226010447e3 \
--l-distr fixed --longitude -37.76739501953125 --latitude 48.19589614868164 --i-distr uniform \
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
