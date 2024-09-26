lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 31.53137137137137 --fixed-mass2 39.51555555555556 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1030709861.3923844 \
--gps-end-time 1030717061.3923844 \
--d-distr volume \
--min-distance 2460.5764695862167e3 --max-distance 2460.596469586217e3 \
--l-distr fixed --longitude -136.14453125 --latitude 20.613065719604492 --i-distr uniform \
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
