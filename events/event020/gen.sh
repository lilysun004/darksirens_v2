lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 16.15131131131131 --fixed-mass2 40.103863863863864 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1008960391.3673002 \
--gps-end-time 1008967591.3673002 \
--d-distr volume \
--min-distance 1085.7179848888316e3 --max-distance 1085.7379848888315e3 \
--l-distr fixed --longitude -104.18167114257812 --latitude 7.378181457519531 --i-distr uniform \
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
