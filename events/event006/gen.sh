lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 2.6202202202202205 --fixed-mass2 33.46438438438439 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1017828672.6447634 \
--gps-end-time 1017835872.6447634 \
--d-distr volume \
--min-distance 311.319103794476e3 --max-distance 311.339103794476e3 \
--l-distr fixed --longitude -140.87628173828125 --latitude -17.87476921081543 --i-distr uniform \
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
