lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 29.262182182182183 --fixed-mass2 44.390110110110115 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1003339873.8743423 \
--gps-end-time 1003347073.8743423 \
--d-distr volume \
--min-distance 1020.786993601773e3 --max-distance 1020.806993601773e3 \
--l-distr fixed --longitude -23.138427734375 --latitude -71.23981475830078 --i-distr uniform \
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
