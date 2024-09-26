lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 62.795755755755756 --fixed-mass2 79.94074074074075 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1020669671.1880164 \
--gps-end-time 1020676871.1880164 \
--d-distr volume \
--min-distance 883.9848607587396e3 --max-distance 884.0048607587396e3 \
--l-distr fixed --longitude -41.390167236328125 --latitude 30.74353790283203 --i-distr uniform \
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
