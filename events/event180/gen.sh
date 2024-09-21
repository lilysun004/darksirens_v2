lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 27.833433433433434 --fixed-mass2 72.88104104104104 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1005543526.2596816 \
--gps-end-time 1005550726.2596816 \
--d-distr volume \
--min-distance 1553.3997327341335e3 --max-distance 1553.4197327341335e3 \
--l-distr fixed --longitude 127.45079040527344 --latitude 67.40400695800781 --i-distr uniform \
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
