lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 74.05765765765766 --fixed-mass2 30.69093093093093 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1005321668.6015662 \
--gps-end-time 1005328868.6015662 \
--d-distr volume \
--min-distance 1967.852630474986e3 --max-distance 1967.872630474986e3 \
--l-distr fixed --longitude 92.72767639160156 --latitude 59.87899398803711 --i-distr uniform \
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
