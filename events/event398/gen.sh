lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 20.857777777777777 --fixed-mass2 75.40236236236237 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1026208937.6665969 \
--gps-end-time 1026216137.6665969 \
--d-distr volume \
--min-distance 829.7799943220441e3 --max-distance 829.7999943220441e3 \
--l-distr fixed --longitude -173.47564697265625 --latitude 0.7030925154685974 --i-distr uniform \
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
