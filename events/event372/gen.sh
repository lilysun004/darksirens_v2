lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 36.91019019019019 --fixed-mass2 31.11115115115115 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1015178600.7940147 \
--gps-end-time 1015185800.7940147 \
--d-distr volume \
--min-distance 1684.6603353584749e3 --max-distance 1684.6803353584748e3 \
--l-distr fixed --longitude 155.0390167236328 --latitude -10.896101951599121 --i-distr uniform \
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
