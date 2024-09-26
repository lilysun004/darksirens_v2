lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 29.514314314314312 --fixed-mass2 55.14774774774775 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1020337601.0899464 \
--gps-end-time 1020344801.0899464 \
--d-distr volume \
--min-distance 4948.77780456784e3 --max-distance 4948.79780456784e3 \
--l-distr fixed --longitude -84.29092407226562 --latitude 54.70649337768555 --i-distr uniform \
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
