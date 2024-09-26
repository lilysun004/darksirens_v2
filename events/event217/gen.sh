lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 18.336456456456457 --fixed-mass2 46.407167167167174 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1021728414.7545956 \
--gps-end-time 1021735614.7545956 \
--d-distr volume \
--min-distance 3705.7418167029787e3 --max-distance 3705.761816702979e3 \
--l-distr fixed --longitude -1.9063720703125 --latitude 44.548255920410156 --i-distr uniform \
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
