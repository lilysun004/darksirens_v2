lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 27.077037037037037 --fixed-mass2 42.289009009009014 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1026967195.6053303 \
--gps-end-time 1026974395.6053303 \
--d-distr volume \
--min-distance 3331.5163368915973e3 --max-distance 3331.536336891598e3 \
--l-distr fixed --longitude -8.59613037109375 --latitude 55.94525909423828 --i-distr uniform \
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
