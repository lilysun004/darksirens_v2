lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 19.26094094094094 --fixed-mass2 15.983223223223224 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1009477636.7646332 \
--gps-end-time 1009484836.7646332 \
--d-distr volume \
--min-distance 1834.7751348925037e3 --max-distance 1834.7951348925037e3 \
--l-distr fixed --longitude 38.49790573120117 --latitude 3.9808170795440674 --i-distr uniform \
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
