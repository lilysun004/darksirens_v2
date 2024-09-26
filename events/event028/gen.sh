lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 29.514314314314312 --fixed-mass2 66.74582582582583 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1026258481.3910929 \
--gps-end-time 1026265681.3910929 \
--d-distr volume \
--min-distance 813.6737712850208e3 --max-distance 813.6937712850208e3 \
--l-distr fixed --longitude 106.85566711425781 --latitude -23.194969177246094 --i-distr uniform \
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
