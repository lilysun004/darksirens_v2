lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 44.306066066066066 --fixed-mass2 51.28172172172172 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1019005560.6196219 \
--gps-end-time 1019012760.6196219 \
--d-distr volume \
--min-distance 1369.2674098053456e3 --max-distance 1369.2874098053455e3 \
--l-distr fixed --longitude 2.3082902431488037 --latitude 66.27433776855469 --i-distr uniform \
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
