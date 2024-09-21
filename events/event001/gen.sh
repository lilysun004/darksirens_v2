lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 30.354754754754754 --fixed-mass2 85.90786786786786 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1000236292.1601002 \
--gps-end-time 1000243492.1601002 \
--d-distr volume \
--min-distance 2971.0264694252382e3 --max-distance 2971.0464694252387e3 \
--l-distr fixed --longitude -151.05712890625 --latitude 30.927310943603516 --i-distr uniform \
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
