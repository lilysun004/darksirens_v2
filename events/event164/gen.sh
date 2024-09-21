lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 38.84320320320321 --fixed-mass2 32.28776776776777 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1025232333.7702394 \
--gps-end-time 1025239533.7702394 \
--d-distr volume \
--min-distance 2790.887331273628e3 --max-distance 2790.9073312736286e3 \
--l-distr fixed --longitude -101.152099609375 --latitude 4.652124881744385 --i-distr uniform \
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
