lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 11.52888888888889 --fixed-mass2 53.13069069069069 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1005792709.8768499 \
--gps-end-time 1005799909.8768499 \
--d-distr volume \
--min-distance 947.1706819815103e3 --max-distance 947.1906819815102e3 \
--l-distr fixed --longitude -48.699737548828125 --latitude -70.37761688232422 --i-distr uniform \
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
