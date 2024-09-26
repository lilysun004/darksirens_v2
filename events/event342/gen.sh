lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 17.916236236236237 --fixed-mass2 24.135495495495494 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1002182205.2427772 \
--gps-end-time 1002189405.2427772 \
--d-distr volume \
--min-distance 2033.6751334275998e3 --max-distance 2033.6951334275998e3 \
--l-distr fixed --longitude -137.53451538085938 --latitude 6.181331157684326 --i-distr uniform \
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
