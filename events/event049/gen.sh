lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 22.874834834834836 --fixed-mass2 17.496016016016018 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1024852530.015365 \
--gps-end-time 1024859730.015365 \
--d-distr volume \
--min-distance 1149.5208713400532e3 --max-distance 1149.5408713400532e3 \
--l-distr fixed --longitude -115.67666625976562 --latitude 36.4886360168457 --i-distr uniform \
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
