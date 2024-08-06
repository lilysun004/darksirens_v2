lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 48.592312312312316 --fixed-mass2 25.73233233233233 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1010950028.8941584 \
--gps-end-time 1010957228.8941584 \
--d-distr volume \
--min-distance 2109.00034334242e3 --max-distance 2109.0203433424203e3 \
--l-distr fixed --longitude -99.82138061523438 --latitude 39.774017333984375 --i-distr uniform \
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
