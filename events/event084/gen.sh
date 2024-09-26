lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 56.07223223223224 --fixed-mass2 80.44500500500502 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1021764427.7133048 \
--gps-end-time 1021771627.7133048 \
--d-distr volume \
--min-distance 1636.8215348985625e3 --max-distance 1636.8415348985625e3 \
--l-distr fixed --longitude -123.47895812988281 --latitude -68.24712371826172 --i-distr uniform \
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
