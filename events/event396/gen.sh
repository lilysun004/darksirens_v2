lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 22.706746746746745 --fixed-mass2 65.65325325325325 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1005250576.7550726 \
--gps-end-time 1005257776.7550726 \
--d-distr volume \
--min-distance 3123.617404576852e3 --max-distance 3123.6374045768525e3 \
--l-distr fixed --longitude -93.97406005859375 --latitude 48.15608215332031 --i-distr uniform \
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
